package SmallRNA::Runable::TrimRunable;

=head1 NAME

SmallRNA::Runable::TrimRunable - a runable that reads a fastq file, removes
  adaptors and/or trims reads and writes fasta output files

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::TrimRunable

You can also look for information at:

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

none - see SmallRNA::RunableI;

=cut

use strict;
use warnings;
use Mouse;
use Carp;
use File::Temp qw(tempdir);
use File::Path;
use File::Copy;

use SmallRNA::Process::TrimProcess;

extends 'SmallRNA::Runable::SmallRNARunable';

sub _get_barcodes
{
  my $schema = shift;
  my $barcode_set_name = shift;

  my $rs = $schema->resultset('BarcodeSet')
    ->search({ name => $barcode_set_name })
    ->search_related('barcodes');

  my %barcodes_map = ();

  while (my $barcode = $rs->next) {
    $barcodes_map{$barcode->code()} = $barcode->identifier();
  }

  return %barcodes_map;
}

sub _find_barcode_set_and_adaptor
{
  my $pipeprocess = shift;

  my $input_pipedata = ($pipeprocess->input_pipedatas())[0];
  my $fastq_generating_pipeprocess = $input_pipedata->generating_pipeprocess();

  my $seq_run_process = undef;

  if ($fastq_generating_pipeprocess->input_pipedatas() > 0) {
    # the fastq file we are processing was generated from an SRF file, which 
    # we need go back to to get the pipeprocess that the sequencingruns hang off
    my $srf_pipedata = ($fastq_generating_pipeprocess->input_pipedatas())[0];
    $seq_run_process = $srf_pipedata->generating_pipeprocess();
  } else {
    $seq_run_process = $fastq_generating_pipeprocess;
  }

  my @sequencingruns = $seq_run_process->sequencingruns();

  my $sequencing_sample = $sequencingruns[0]->sequencing_sample();
  my @libraries = $sequencing_sample->libraries();

  my $sample_barcode = $libraries[0]->barcode();
  my $sample_adaptor = $libraries[0]->adaptor();

  if (defined $sample_barcode) {
    return ($sample_barcode->barcode_set(), $sample_adaptor);
  } else {
    return (undef, $sample_adaptor);
  }
}

sub _find_sequencingrun_from_pipedata
{
  my $pipedata = shift;

  my @sequencingruns = $pipedata->sequencingruns();

  if (@sequencingruns > 1) {
    croak ("pipedata ", $pipedata->pipedata_id(),
           " has more than one sequencingrun object\n");
  }

  return $sequencingruns[0];
}

sub _find_biosample_from_code
{
  my $pipedata = shift;
  my $code = shift;

  my $sequencingrun = _find_sequencingrun_from_pipedata($pipedata);

  my $sequencing_sample = $sequencingrun->sequencing_sample();

  my @libraries = $sequencing_sample->libraries();

  my $biosample = undef;

  for my $library (@libraries) {
    if ($library->barcode()->code() eq $code) {
      if (defined $biosample) {
        croak ("two biosamples used the same barcode: ", $biosample->biosample_id(),
               " and ", $library->biosample());
      } else {
        $biosample = $library->biosample();
      }
    }
  }

  return $biosample;
}

sub _check_terms
{
  my $schema = shift;
  my @term_names = @_;

  for my $term_name (@term_names) {
    $schema->find_with_type('Cvterm', name => $term_name);
  }
}

=head2

 Function: Run TrimRunableProcess for this Runable/pipeprocess and store the
           name of the resulting files in the pipedata table.
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my $self = shift;

  my $schema = $self->schema();

  my $reject_term_name = 'trim_rejects';
  my $n_reject_term_name = 'trim_n_rejects';
  my $unknown_barcode_term_name = 'trim_unknown_barcode';

  my $pipeprocess =
    $self->pipeprocess();
  $self->{_conf} = $pipeprocess->process_conf();

  my $processing_type = 'passthrough';

  my $detail = $self->{_conf}->detail();

  if (defined $detail && $detail =~ /^action: (.*)/) {
    $processing_type = $1;
  }

  my @input_pipedatas = $pipeprocess->input_pipedatas();

  if (@input_pipedatas > 1) {
    croak ("pipeprocess ", $pipeprocess->pipeprocess_id(),
           " has more than one input pipedata\n");
  }

  my $input_pipedata = $input_pipedatas[0];

  my $biosample_type;

  my @biosamples = $input_pipedata->biosamples();

  for my $biosample (@biosamples) {
    if (defined $biosample_type) {
      if ($biosample->biosample_type()->name() ne $biosample_type) {
        croak ('pipedata ' . $input_pipedata->pipedata_id() . 
               ' has more than 1 biosample, but with differing biosample_types ' .
               ' - not supported');
      }
    } else {
      $biosample_type = $biosample->biosample_type()->name();
    }
  }

  my $kept_term_name = 'trimmed_reads';
  my $raw_reads = 'raw_reads';

  _check_terms($schema, $kept_term_name, $reject_term_name,
               $unknown_barcode_term_name, $raw_reads);


  my $fasta_output_term_name = $raw_reads;

  my $sequencingrun = _find_sequencingrun_from_pipedata($input_pipedata);

  my $code = sub {
    my @input_files = $self->input_files();

    if (@input_files != 1) {
      croak "Remove adaptors needs one input file\n";
    }

    my $data_dir = $self->config()->data_directory();

    my $temp_output_dir = tempdir("$data_dir." . $pipeprocess->pipeprocess_id() .
                                  '.XXXXX', CLEANUP => 1);

    my $reject_file_name;
    my $n_reject_file_name;
    my $fasta_file_name;
    my $output;

    my $input_file_name = $data_dir . '/' . $input_files[0];

    my ($barcode_set, $adaptor) = _find_barcode_set_and_adaptor($pipeprocess);

    my $trim_offset = 0;

    if (defined $barcode_set && $trim_offset == 0) {
      # do de-multiplexing
      my $barcode_position = $barcode_set->position_in_read()->name();

      my %barcodes_map = _get_barcodes($schema, $barcode_set->name());

      ($reject_file_name, $n_reject_file_name, $fasta_file_name, $output) =
        SmallRNA::Process::TrimProcess::run(
                                                      output_dir_name => $temp_output_dir,
                                                      input_file_name => $input_file_name,
                                                      processing_type => $processing_type,
                                                      barcodes => \%barcodes_map,
                                                      barcode_position => $barcode_position,
                                                      trim_offset => $trim_offset,
                                                      adaptor_sequence => $adaptor->definition()
                                                     );

      for my $code (keys %{$output}) {
        my $biosample = _find_biosample_from_code(@input_pipedatas, $code);

        my $code_name = $barcodes_map{$code};

        my $output_dir = $data_dir;
        mkpath($output_dir . "/$unknown_barcode_term_name");
        my $temp_file_name = $output->{$code};
        my $new_file_name = $temp_file_name;
        my $sequencingrun_identifier = $sequencingrun->identifier();

        my $content_type_name;

        my @biosamples = ();

        if (defined $biosample) {
          push @biosamples, $biosample;

          my $biosample_name = $biosample->name();
          mkpath($output_dir . '/' . $biosample_name);
          if (!($new_file_name =~ s|(?:$sequencingrun_identifier\.)?(.*?)(?:\.$code_name)\.fasta$|$biosample_name/$biosample_name.$kept_term_name.fasta|)) {
            croak "pattern match failed for $new_file_name\n";
          }
          $content_type_name = $kept_term_name;
        } else {
          if (!($new_file_name =~ s|(.*?)\.fasta$|$unknown_barcode_term_name/$1.$unknown_barcode_term_name.fasta|)) {
            croak "pattern match failed for $new_file_name\n";
          }
          $content_type_name = $unknown_barcode_term_name;
        }

        move("$temp_output_dir/$temp_file_name", "$output_dir/$new_file_name");
        $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                              file_name => $new_file_name,
                              format_type_name => 'fasta',
                              content_type_name => $content_type_name,
                              biosamples => [@biosamples],
                              properties => { 'multiplexing code' => $code_name });
      }
    } else {
      ($reject_file_name, $n_reject_file_name, $fasta_file_name, $output) =
        SmallRNA::Process::TrimProcess::run(
                                                      output_dir_name => $temp_output_dir,
                                                      input_file_name => $input_file_name,
                                                      processing_type => $processing_type,
                                                      adaptor_sequence => $adaptor->definition()
                                                     );

      my $biosample = $biosamples[0];

      my $temp_dir_output_file_name = "$temp_output_dir/$output";

      if (!-f $temp_dir_output_file_name) {
        croak "output file $temp_dir_output_file_name missing from TrimProcess->run()\n";
      }

      # the directory is just the biosample name
      my $biosample_name = $biosample->name();
      my $new_output_name = $output;
      $new_output_name =~ s|(.*)\.fasta$|$biosample_name/$biosample_name.$kept_term_name.fasta|;

      mkpath("$data_dir/$biosample_name");
      move($temp_dir_output_file_name, "$data_dir/$new_output_name");

      $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                            file_name => $new_output_name,
                            format_type_name => 'fasta',
                            content_type_name => $kept_term_name,
                            biosamples => \@biosamples);
    }

    # store reject file
    my $new_reject_file_name = $reject_file_name;

    if (!($new_reject_file_name =~ s|(.*)\.rejects\.fasta$|$reject_term_name/$1.$reject_term_name.fasta|)) {
      croak "pattern match failed for $new_reject_file_name\n";
    }

    my $reject_output_dir = $data_dir . "/$reject_term_name";
    mkpath($reject_output_dir);

    die unless -e "$temp_output_dir/$reject_file_name";

    move("$temp_output_dir/$reject_file_name", "$data_dir/$new_reject_file_name");

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $new_reject_file_name,
                          format_type_name => 'fasta',
                          content_type_name => $reject_term_name,
                          biosamples => [$input_pipedata->biosamples()]);

    # store n-reject file (reads containing 'N's)
    my $new_n_reject_file_name = $n_reject_file_name;

    if (!($new_n_reject_file_name =~ s|(.*)\.n-rejects\.fasta$|$n_reject_term_name/$1.$n_reject_term_name.fasta|)) {
      croak "pattern match failed for $new_n_reject_file_name\n";
    }

    my $n_reject_output_dir = $data_dir . "/$n_reject_term_name";
    mkpath($n_reject_output_dir);

    die unless -e "$temp_output_dir/$n_reject_file_name";

    move("$temp_output_dir/$n_reject_file_name", "$data_dir/$new_n_reject_file_name");

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $new_n_reject_file_name,
                          format_type_name => 'fasta',
                          content_type_name => $n_reject_term_name,
                          biosamples => [$input_pipedata->biosamples()]);

    my $new_fasta_file_name = $fasta_file_name;

    if (!($new_fasta_file_name =~ s|(.*)\.reads\.fasta$|$fasta_output_term_name/$1.$fasta_output_term_name.fasta|)) {
      croak "pattern match failed for $new_fasta_file_name\n";
    }

    my $fasta_output_dir = $data_dir . "/$fasta_output_term_name";
    mkpath($fasta_output_dir);

    die unless -e "$temp_output_dir/$fasta_file_name";

    move("$temp_output_dir/$fasta_file_name", "$data_dir/$new_fasta_file_name");

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $new_fasta_file_name,
                          format_type_name => 'fasta',
                          content_type_name => $fasta_output_term_name,
                          biosamples => [$input_pipedata->biosamples()]);
  };
  $self->schema->txn_do($code);
}

1;
