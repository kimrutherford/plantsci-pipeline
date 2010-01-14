package SmallRNA::Runable::AlignmentRunable;

=head1 NAME

SmallRNA::Runable::AlignmentRunable - Run, parse and save the results of running
                                      an alignment program

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::AlignmentRunable

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
use Carp;
use Mouse;

use SmallRNA::Process::SSAHASearchProcess;

extends 'SmallRNA::Runable::SmallRNARunable';

=head2

 Function: Run SSAHASearchProcess for this Runable/pipeprocess and store the
           name of the resulting gff file in the pipedata table.
 Returns : nothing - either succeeds or calls die()

=cut
sub run_alignment
{
  my $self = shift;
  my $alignment_program = shift;
  my $extra_alignment_args_ref = shift;
  my %extra_alignment_args = %$extra_alignment_args_ref;

  my $schema = $self->schema();

  my $pipeprocess = $self->pipeprocess();
  my $process_class = $self->config()->{programs}->{$alignment_program}->{process_class};

  my $code = sub {

    my @input_pipedatas = $pipeprocess->input_pipedatas();
    my $pipeprocess_id = $pipeprocess->pipeprocess_id();

    if (@input_pipedatas > 1) {
      croak ("pipeprocess ", $pipeprocess_id,
             " has more than one input pipedata\n");
    }

    my $input_pipedata = $input_pipedatas[0];

    my @biosamples = $input_pipedata->biosamples();

    if (@biosamples != 1) {
      croak("pipedata has more than one biosample, can't continue: ",
            $input_pipedata->file_name(), "\n");
    }

    my $c = $self->config()->{programs}{$alignment_program};

    my $biosample = $biosamples[0];

    my $data_dir = $self->config()->data_directory();
    my $process_conf = $pipeprocess->process_conf();
    my $detail = $process_conf->detail();

    my @process_conf_inputs = $process_conf->process_conf_inputs();

    if (@process_conf_inputs != 1) {
      croak("process conf for process #", $pipeprocess_id,
            " has more than one input configured\n");
    }

    if ($detail =~ /component: ([^,]+)/) {
      my $component = $1;
      my @biosample_ecotypes = $biosample->ecotypes();

      my $org_full_name;

      if ($detail =~ /target: "([^"]+)"/) {
        $org_full_name = $1;
      } else {
        my $target_organism = $process_conf_inputs[0]->ecotype()->organism();
        $org_full_name = $target_organism->full_name();
      }

      $org_full_name =~ s/ /_/g;

      my $database_conf = $self->config()->{databases};

      my $org_config = $database_conf->{organisms}{$org_full_name};

      if (!defined $org_config) {
        croak("no configuration found for $org_full_name for process #",
              $pipeprocess_id, "\n");
      }

      if (!defined $org_config) {
        croak "can't find organism configuration for ", $biosample->name(), "\n";
      }

      if (!defined $org_config->{database_files}{$component}) {
        die "can't find configuration for component: $component\n";
      }

      my $db_file_name = $database_conf->{root} . '/' . $org_config->{database_files}{$component};

      my $executable_path = $c->{path};

      my $input_file_name = $input_pipedata->file_name();
      my $gff_file_name = $input_file_name;

      my $org_text = ".v_${org_full_name}_$component";

      if(! ($gff_file_name =~ s/\.non_redundant_reads\.fasta/$org_text.$alignment_program.gff3/)) {
        croak qq{file name ("$gff_file_name") doesn't contain the string "non_redundant"};
      }

      my $non_aligned_file_name = $input_file_name;

      $non_aligned_file_name =~ s/\.non_redundant_reads\.fasta/$org_text.non_aligned_reads.$alignment_program.fasta/;

      my @non_aligned_args = ();

      if ($component eq 'genome') {
        @non_aligned_args =
          (non_aligned_file_name => "$data_dir/$non_aligned_file_name");
      }

      eval <<"EVAL_BLOCK";
use $process_class;

${process_class}::run(input_file_name =>
                        "\$data_dir/" . \$input_file_name,
                      gff_source_name => \$biosample->name(),
                      executable_path => \$executable_path,
                      output_gff_file_name =>
                        "\$data_dir/" . \$gff_file_name,
                      database_file_name =>
                        \$db_file_name,
                      \@non_aligned_args,
                      \%extra_alignment_args);
EVAL_BLOCK

      croak "eval failed: $@" if $@;

      $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                            file_name => $gff_file_name,
                            format_type_name => 'gff3',
                            content_type_name => 'aligned_reads',
                            properties => { 'alignment component' => $component,
                                            'alignment ecotype' => $org_full_name,
                                            'alignment program' => $alignment_program});

      if ($component eq 'genome') {
        $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                              file_name => $non_aligned_file_name,
                              format_type_name => 'fasta',
                              content_type_name => 'non_aligned_reads');
      }
    } else {
      croak ("can't understand detail: $1 for pipeprocess: ", $pipeprocess_id);
    }

  };
  $self->schema->txn_do($code);
}

1;

