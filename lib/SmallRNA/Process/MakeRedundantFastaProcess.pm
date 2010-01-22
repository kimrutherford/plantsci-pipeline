package SmallRNA::Process::MakeRedundantFastaProcess;

=head1 NAME

SmallRNA::Process::MakeRedundantFastaProcess - Create a redundant FASTA file
   from a non-redundant FASTA file

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::MakeRedundantFastaProcess

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

use Params::Validate qw(:all);

use Bio::SeqIO;

=head2

 Usage   : SmallRNA::Process::MakeRedundantFastaProcess(input_file_name =>
                                                          $in_file_name,
                                                        output_file_name =>
                                                          $out_file_name);
 Function: Create a redundant FASTA file from the non-redundant input file.
           The records in the input file need to have a count:<num> in the
           header to show how many times the read/sequence occurs in the input.
 Args    : input_file_name - the input file name of sequences in FASTA format
           output_file_name - the name of the file to write the redundant
                              sequences to
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my %params = validate(@_, { input_file_name => 1,
                              output_file_name => 1,
                            });

  my $input_file_name = $params{input_file_name};
  my $output_file_name = $params{output_file_name};

  my $seqio = Bio::SeqIO->new(-file => $params{input_file_name} ,
                              -format => 'Fasta');

  open my $outfile, '>', $output_file_name
    or die "can't open $output_file_name: $!\n";

  my $record_count = 0;

  while (my $record = $seqio->next_seq()) {
    my $id = $record->id();
    my $seq = $record->seq();
    my $desc = $record->desc();

    if ($desc =~ /count:\s*(\d+)/) {
      my $count = $1;

      for (my $i = 0; $i < $count; $i++) {
        print $outfile <<"END";
>$id
$seq
END
        $record_count++;

        if ($ENV{'SMALLRNA_PIPELINE_TEST'} && $record_count > 1000) {
          last;
        }
      }

    } else {
      die "can't find count in header: $desc\n";
    }
  }

  close $outfile or die "can't close $output_file_name: $!\n";
}

1;

