package SmallRNA::Runable::BWASearchRunable;

=head1 NAME

SmallRNA::Runable::BWASearchRunable - Run, parse and save the results of a
                                        BWA search

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::BWASearchRunable

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
use Moose;

use SmallRNA::Process::BWASearchProcess;

extends 'SmallRNA::Runable::SmallRNARunable';

=head2

 Function: Run BWASearchProcess for this Runable/pipeprocess and store the
           name of the resulting sam file in the pipedata table.
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my $self = shift;
  my $schema = $self->schema();

  my $code = sub {
    my $pipeprocess = $self->pipeprocess();

    my @input_pipedatas = $pipeprocess->input_pipedatas();
    my $pipeprocess_id = $pipeprocess->pipeprocess_id();

    if (@input_pipedatas > 1) {
      croak ("pipeprocess ", $pipeprocess_id,
             " has more than one input pipedata\n");
    }

    my $input_pipedata = $input_pipedatas[0];

    my $c = $self->config()->{programs}{bwa};
    my $bwa_path = $c->{path};

    my ($org_full_name, $component, $db_file_name) =
      $self->get_pipeprocess_details($pipeprocess);

    my $input_file_name = $input_pipedata->file_name();
    my $sam_file_name = $input_file_name;

    my $new_suffix = ".v_${org_full_name}_$component.bwa.sam";

    if(! ($sam_file_name =~ s/\.non_redundant_reads\.fasta/$new_suffix/)) {
      croak qq{file name ("$sam_file_name") doesn't contain the string "non_redundant"};
    }

    my $data_dir = $self->config()->data_directory();

    SmallRNA::Process::BWASearchProcess::run(input_file_name =>
                                               "$data_dir/" . $input_file_name,
                                             bwa_path => $bwa_path,
                                             output_file_name =>
                                               "$data_dir/" . $sam_file_name,
                                             database_file_name =>
                                               $db_file_name);

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $sam_file_name,
                          format_type_name => 'sam',
                          content_type_name => 'aligned_reads',
                          properties => { 'alignment component' => $component,
                                          'alignment ecotype' => $org_full_name,
                                          'alignment program' => 'bwa'});
  };
  $self->schema->txn_do($code);
}

1;

