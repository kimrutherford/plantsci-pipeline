package SmallRNA::Runable::TrimRunable;

=head1 NAME

SmallRNA::Runable::TrimRunable - a runable that reads a fastq file, removes
  adapters and/or trims reads and writes fasta output files

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
use Moose;
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

sub _find_barcode_set
{
  my $pipeprocess = shift;

  my $input_pipedata = ($pipeprocess->input_pipedatas())[0];
  my $seq_run_process = $input_pipedata->generating_pipeprocess();

  my @sequencingruns = $seq_run_process->sequencingruns();
  my $sequencing_sample = $sequencingruns[0]->sequencing_sample();
  my @coded_samples = $sequencing_sample->coded_samples();

  my $sample_barcode = $coded_samples[0]->barcode();

  if (defined $sample_barcode) {
    return $sample_barcode->barcode_set();
  } else {
    return undef;
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

sub _find_sample_from_code
{
  my $pipedata = shift;
  my $code = shift;

  my $sequencingrun = _find_sequencingrun_from_pipedata($pipedata);

  my $sequencing_sample = $sequencingrun->sequencing_sample();

  my @coded_samples = $sequencing_sample->coded_samples();

  my $sample = undef;

  for my $coded_sample (@coded_samples) {
    if ($coded_sample->barcode()->code() eq $code) {
      if (defined $sample) {
        croak ("two samples used the same barcode: ", $sample->sample_id(),
               " and ", $coded_sample->sample());
      } else {
        $sample = $coded_sample->sample();
      }
    }
  }

  return $sample;
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

  my $reject_term_name = 'remove_adapter_rejects';
  my $unknown_barcode_term_name = 'remove_adapter_unknown_barcode';

  my $raw_srna_reads = 'raw_srna_reads';
  my $multiplexed_srna_reads = 'multiplexed_srna_reads';

  my $fasta_output_term_name;

  my $pipeprocess =
    $self->pipeprocess();
  $self->{_conf} = $pipeprocess->process_conf();

  my $processing_type;

  my $detail = $self->{_conf}->detail();

  if ($detail =~ /^action: (.*)/) {
    $processing_type = $1;
  }

  my @input_pipedatas = $pipeprocess->input_pipedatas();

  if (@input_pipedatas > 1) {
    croak ("pipeprocess ", $pipeprocess->pipeprocess_id(),
           " has more than one input pipedata\n");
  }

  my $input_pipedata = $input_pipedatas[0];

  my $kept_term_name;

  if ($input_pipedata->content_type()->name() eq 'raw_genomic_dna_reads') {
    if ($processing_type eq 'trim') {
      $kept_term_name = 'genomic_dna_tags';
    } else {
      $kept_term_name = 'genomic_dna_reads';
    }
  } else {
    $kept_term_name = 'srna_reads';
  }

  _check_terms($schema, $kept_term_name, $reject_term_name,
               $unknown_barcode_term_name, $raw_srna_reads,
               $multiplexed_srna_reads);


  my $sequencingrun = _find_sequencingrun_from_pipedata($input_pipedata);

  my $code = sub {
    my @input_files = $self->input_files();

    if (@input_files != 1) {
      croak "Remove adapters needs one input file\n";
    }

    my $data_dir = $self->config()->data_directory();

    my $temp_output_dir = tempdir("$data_dir." . $pipeprocess->pipeprocess_id() .
                                  '.XXXXX', CLEANUP => 1);

    my $reject_file_name;
    my $fasta_file_name;
    my $output;

    my $input_file_name = $data_dir . '/' . $input_files[0];

    my $barcode_set = _find_barcode_set($pipeprocess);

    my $trim_offset = 0;

    if (defined $barcode_set && $trim_offset == 0) {
      # do de-multiplexing
      $fasta_output_term_name = $multiplexed_srna_reads;

      my $barcode_position = $barcode_set->position_in_read()->name();

      my %barcodes_map = _get_barcodes($schema, $barcode_set->name());

      ($reject_file_name, $fasta_file_name, $output) =
        SmallRNA::Process::TrimProcess::run(
                                                      output_dir_name => $temp_output_dir,
                                                      input_file_name => $input_file_name,
                                                      processing_type => $processing_type,
                                                      barcodes => \%barcodes_map,
                                                      barcode_position => $barcode_position,
                                                      trim_offset => $trim_offset
                                                     );

      for my $code (keys %{$output}) {
        my $sample = _find_sample_from_code(@input_pipedatas, $code);

        my $code_name = $barcodes_map{$code};

        my $output_dir = $data_dir;
        mkpath($output_dir . "/$unknown_barcode_term_name");
        my $temp_file_name = $output->{$code};
        my $new_file_name = $temp_file_name;
        my $sequencingrun_identifier = $sequencingrun->identifier();

        my $content_type_name;

        my @samples = ();

        if (defined $sample) {
          push @samples, $sample;

          my $sample_name = $sample->name();
          mkpath($output_dir . '/' . $sample_name);
          if (!($new_file_name =~ s|(?:$sequencingrun_identifier\.)?(.*?)(?:\.$code_name)\.fasta$|$sample_name/$sample_name.$kept_term_name.fasta|)) {
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
                              samples => [@samples],
                              properties => { 'multiplexing code' => $code_name });
      }
    } else {
      $fasta_output_term_name = $raw_srna_reads;

      ($reject_file_name, $fasta_file_name, $output) =
        SmallRNA::Process::TrimProcess::run(
                                                      output_dir_name => $temp_output_dir,
                                                      input_file_name => $input_file_name,
                                                      processing_type => $processing_type,
                                                     );

      my @samples = $input_pipedata->samples();
      my $sample = $samples[0];

      my $temp_dir_output_file_name = "$temp_output_dir/$output";

      if (!-f $temp_dir_output_file_name) {
        croak "output file $temp_dir_output_file_name missing from TrimProcess->run()\n";
      }

      # the directory is just the sample name
      my $sample_name = $sample->name();
      my $new_output_name = $output;
      $new_output_name =~ s|(.*)\.fasta$|$sample_name/$sample_name.$kept_term_name.fasta|;

      mkpath("$data_dir/$sample_name");
      move($temp_dir_output_file_name, "$data_dir/$new_output_name");

      $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                            file_name => $new_output_name,
                            format_type_name => 'fasta',
                            content_type_name => $kept_term_name,
                            samples => \@samples);
    }

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
                          samples => [$input_pipedata->samples()]);

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
                          samples => [$input_pipedata->samples()]);
  };
  $self->schema->txn_do($code);
}

1;
