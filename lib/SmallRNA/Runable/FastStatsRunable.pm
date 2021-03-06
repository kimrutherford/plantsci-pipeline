package SmallRNA::Runable::FastStatsRunable;

=head1 NAME

SmallRNA::Runable::FastStatsRunable - A Runable that summarises the content
                                      and sequence ecomposition of a FASTQ or
                                      FASTA file

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::FastStatsRunable

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
use Moose;
use Carp;

use SmallRNA::Process::FastStatsProcess;

extends 'SmallRNA::Runable::SmallRNARunable';

=head2

 Function: Create a file with summary/statistical information about a FASTQ or
           FASTA file
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
    my $data_dir = $self->config()->data_directory();

    my $input_file_name = $input_pipedata->file_name();
    my $out_file_name = $input_file_name;

    my $stats_term_name = 'fast_stats';

    $out_file_name =~ s/(\.(fast[aq]|f[aq]))?$/.fast_stats/i;

    my $n_mer_file_name = $out_file_name;

    $n_mer_file_name =~ s/\.fast_stats/.n-mer/;

    my $results =
      SmallRNA::Process::FastStatsProcess::run(input_file_name =>
                                                 "$data_dir/" . $input_file_name,
                                               output_file_name =>
                                                 "$data_dir/" . $out_file_name,
                                               n_mer_file_name =>
                                                 "$data_dir/" .  $n_mer_file_name,
                                               max_stats_n_mers => 10);

    for my $prop_type_name (sort keys %$results) {
      my $type_cvterm = $schema->resultset('Cvterm')->find({name => $prop_type_name});
      if (defined $type_cvterm) {
        my $create_args = {
          type => $type_cvterm,
          value => $results->{$prop_type_name},
          pipedata => $input_pipedata
        };
        $schema->create_with_type('PipedataProperty', $create_args);
      }
    }

    my @biosamples = $input_pipedata->biosamples();

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $out_file_name,
                          format_type_name => 'text',
                          content_type_name => $stats_term_name,
                          biosamples => \@biosamples);

    if (keys %{$results->{'top-n-mers'}}) {
      $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                            file_name => $n_mer_file_name,
                            format_type_name => 'text',
                            content_type_name => 'n_mer_stats',
                            biosamples => \@biosamples);

    }
  };

  $self->schema->txn_do($code);
}

1;
