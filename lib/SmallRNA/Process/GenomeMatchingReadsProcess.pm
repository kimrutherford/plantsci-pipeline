package SmallRNA::Process::GenomeMatchingReadsProcess;

=head1 NAME

SmallRNA::Process::GenomeMatchingReadsProcess - Read a GFF3 file and create
                            files containing only genome matching reads

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::GenomeMatchingReadsProcess

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

=head2

 Usage:
   SmallRNA::Process::MakeRedundantFastaProcess(input_gff3_file_name =>
                                                  $in_gff3_file_name,
                                                fasta_output_file_name =>
                                                  $fasta_output_file_name,
                                                redundant_fasta_output_file_name =>
                                                  $redundant_fasta_output_file_name,
                                                tsv_output_file_name =>
                                                  $tsv_output_file_name);
 Function: Create a FASTA files from a GFF3 file.  The input file should be in
           the format produced by an AlignmentProcess, with the score being the
           read count.  The count will be used to add the count to the header
           of the fasta output
 Args    : input_gff3_file_name - the input GFF3 file name
           fasta_output_file_name - the name of the file to write the
             non-redundant FASTA output to, with the count in the header
           redundant_fasta_output_file_name - the name of the file to write
             the redundant fasta file to
           tsv_output_file_name - the file name for the sequences and counts
             in tab separated format
 Returns : nothing - either succeeds or calls die()
=cut
sub run
{
  my %params = validate(@_, { input_gff3_file_name => 1,
                              fasta_output_file_name => 1,
                              redundant_fasta_output_file_name => 1,
                              tsv_output_file_name => 1,
                            });

  my $input_gff3_file_name = $params{input_gff3_file_name};
  my $fasta_output_file_name = $params{fasta_output_file_name};
  my $redundant_fasta_output_file_name = $params{redundant_fasta_output_file_name};
  my $tsv_output_file_name = $params{tsv_output_file_name};

  my %read_counts = ();

  open my $gff_file, '<', $input_gff3_file_name
    or croak "can't open $input_gff3_file_name for reading: $!\n";

  while (my $line = <$gff_file>) {
    next if $line =~ /^\s*#/;

    my @bits = split /\t/, $line;
    my $count = $bits[5];
    my $attributes = $bits[8];

    if ($attributes =~ /Name=(\w+)/) {
      my $seq = $1;
      if (exists $read_counts{$seq}) {
        if ($read_counts{$seq} != $count) {
          croak "inconsistent counts in gff file, line: $line\n";
        }
      } else {
        $read_counts{$seq} = $count;
      }
    } else {
      croak "can't find Name in gff3 line: $line\n";
    }
  }

  close $gff_file or croak "can't close $input_gff3_file_name: $!";

  open my $fasta_out_file, '>', $fasta_output_file_name
    or die "can't open $fasta_output_file_name: $!\n";

  open my $redundant_fasta_out_file, '>', $redundant_fasta_output_file_name
    or die "can't open $redundant_fasta_output_file_name: $!\n";

  open my $tsv_output_file, '>', $tsv_output_file_name
    or die "can't open $tsv_output_file_name: $!\n";

  for my $sequence (sort keys %read_counts) {
    my $count = $read_counts{$sequence};

    print $fasta_out_file <<"END";
>$sequence count:$count
$sequence
END
    print $tsv_output_file "$sequence\t$count\n";

    for (my $i = 0; $i < $count; $i++) {
      print $redundant_fasta_out_file <<"END";
>$sequence-$i
$sequence
END
    }
  }

  close $fasta_out_file or die "can't close $fasta_output_file_name: $!\n";
  close $redundant_fasta_out_file or die "can't close $redundant_fasta_output_file_name: $!\n";
  close $tsv_output_file or die "can't close $tsv_output_file_name: $!\n";


}


1;
