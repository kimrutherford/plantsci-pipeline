package SmallRNA::Process::SizeFilterProcess;

=head1 NAME

SmallRNA::Process::SizeFilterProcess - Filter sequences by size

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::SizeFilterProcess

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
use Bio::SeqIO;
use Params::Validate qw(:all);

=head2

 Usage   : SmallRNA::Process::SizeFilterProcess::run(input_file_name =>
                                                       $in_file_name,
                                                     output_file_name =>
                                                       $out_file_name,
                                                     min_size => 15);
 Function: Read a FASTA file and write only those sequences that match the size
           constraints
 Args    : input_file_name - the input file name
           output_file_name - the output file name
           min_size - the minimum size of reads written to the output file
 Returns : nothing - either succeeds or calls croak()

=cut
sub run
{
  my %params = validate(@_, { input_file_name => 1, output_file_name => 1,
                              min_size => 1 });

  if (!-e $params{input_file_name}) {
    croak "can't find input file: $params{input_file_name}";
  }

  my $seq_in = Bio::SeqIO->new(-file => $params{input_file_name},
                               -format => 'Fasta');

  my $seq_out = Bio::SeqIO->new(-file => ">$params{output_file_name}",
                                -format => 'Fasta');

  while (defined (my $seq_obj = $seq_in->next_seq())) {
    if (length $seq_obj->seq() >= $params{min_size}) {
      $seq_out->write_seq($seq_obj);
    }
  }

  $seq_in->close();
  $seq_out->close();
}

1;
