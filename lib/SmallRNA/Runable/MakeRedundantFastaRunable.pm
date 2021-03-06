package SmallRNA::Runable::MakeRedundantFastaRunable;

=head1 NAME

SmallRNA::Runable::MakeRedundantFastaRunable

Creates a redundant version of FASTA file, from a non-redundant FASTA file
(ie. with counts in the header)

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::MakeRedundantFastaRunable

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

=cut

use strict;
use warnings;
use Carp;

use Moose;

use SmallRNA::Process::MakeRedundantFastaProcess;

extends 'SmallRNA::Runable::SmallRNARunable';

=head2

 Function: Run MakeRedundantFastaProcess for this Runable/pipeprocess and store
           the name of the result file in the pipedata table.
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my $self = shift;
  my $schema = $self->schema();

  my $code = sub {
    my $pipeprocess = $self->pipeprocess();

    my @input_pipedatas = $pipeprocess->input_pipedatas();
    if (@input_pipedatas > 1) {
      croak ("pipeprocess ", $pipeprocess->pipeprocess_id(),
             " has more than one input pipedata\n");
    }
    my $input_pipedata = $input_pipedatas[0];

    my $input_type = $input_pipedata->content_type()->name();
    my $output_type = $input_type;

    $output_type =~ s/non_redundant_/redundant_/;

    my $data_dir = $self->config()->data_directory();

    my $input_file_name = $input_pipedata->file_name();

    my $output_file_name = $input_file_name;

    if (!($output_file_name =~ s/$input_type/$output_type/g)) {
      $output_file_name =~ s/\.(fa|fasta)$/.$output_type.fasta/g
    }

    SmallRNA::Process::MakeRedundantFastaProcess::run(input_file_name =>
                                                        "$data_dir/" . $input_file_name,
                                                      output_file_name =>
                                                        "$data_dir/" . $output_file_name);


    # copy properties to new file
    my @properties = $input_pipedata->pipedata_properties();
    my %props_map = ();

    for my $property (@properties) {
      if ($property->type()->name() =~ /^alignment .*/) {
        $props_map{$property->type()->name()} = $property->value();
      }
    }

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $output_file_name,
                          format_type_name => 'fasta',
                          content_type_name => $output_type,
                          properties => \%props_map);
  };
  $self->schema->txn_do($code);
}

1;

