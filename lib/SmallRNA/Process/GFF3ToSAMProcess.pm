package SmallRNA::Process::GFF3ToSAMProcess;

=head1 NAME

SmallRNA::Process::GFF3ToSAMProcess - Convert a GFF3 file to a SAM file

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::GFF3ToSAMProcess

You can also look for information at:

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

=cut

use strict;
use Carp;

use Bio::Seq;
use Bio::SeqIO;
use Params::Validate qw(:all);
use warnings;

=head2

 Usage   : SmallRNA::Process::GFF3ToSAMProcess::run(input_file_name =>
                                                       $in_file_name,
                                                     output_file_name =>
                                                       $out_file_name);
 Function: Convert a GFF3 file to a SAM file
 Args    : input_file_name - the input file name
           output_file_name - the name of the file to write the SAM output to
 Returns : nothing - either succeeds or calls croak()

=cut
sub run
{
  my %params = validate(@_, { input_file_name => 1, output_file_name => 1 });

  if (!-e $params{input_file_name}) {
    croak "can't find input file: $params{input_file_name}";
  }

  open my $in_file, '<', $params{input_file_name}
    or croak "can't open $params{input_file_name} for reading: $!";

  open my $out_file, '>', $params{output_file_name}
    or croak "can't open $params{output_file_name} for reading: $!";

  while (defined (my $line = <$in_file>)) {
    next if $line =~ /^\s*#/;

    my @bits = split (/\t/, $line);

    my ($ref_name, $source, $type, $start, $end, $score, $strand, $phase,
        $attributes) = @bits;

    my $id;
    my $sequence;

    if ($attributes =~ /ID=([^;]+);Name=([^;]+)/) {
      $id = $1;
      $sequence = $2;
    } else {
      croak "can't find ID and Name in GFF3 line: $line";
    }

    my $cigar = (length $sequence) . 'M';

    my $flags;

    if ($strand eq '+') {
      $flags = 0;
    } else {
      $flags = 16;

      my $seq = Bio::Seq->new(-seq => $sequence);
      $sequence = $seq->revcom()->seq();
    }

    print $out_file "$id\t$flags\t$ref_name\t$start\t255\t$cigar\t=\t$start\t0\t$sequence\t*\tXS:i:$score\n";
  }

  close $in_file or croak "can't close $params{input_file_name}: $!\n";
  close $out_file or croak "can't close $params{output_file_name}: $!\n";
}

1;
