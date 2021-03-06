package SmallRNA::Process::SSAHASearchProcess;

=head1 NAME

SmallRNA::Process::SSAHASearchProcess - Run a SSAHA search

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::SSAHASearchProcess

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

use SmallRNA::Parse::SSAHA;

my $SSAHA_ARGS = "-qf fasta -sf fasta -wl 10 -sl 1 -da 0 -mp 18";

sub _write
{
  my $gff_file = shift;
  my $source_name = shift;
  my $match = shift;
  my $count = shift;
  my $strand;
  if ($match->{forward_match}) {
    $strand = '+';
  } else {
    $strand = '-';
  }

  my $start = $match->{sstart};
  my $end = $match->{send};

  my $id = "ID=$match->{qid}-$start-$end";

  my $attributes = "$id;Name=$match->{qid};Note=$match->{qid}";

  my $line = "$match->{sid}\t$source_name\tssaha\t$start\t" .
    "$end\t$count\t$strand\t.\t$attributes";
  print $gff_file "$line\n";
}

=head2

 Usage   : SmallRNA::Process::SSAHASearchProcess(input_file_name =>
                                                   $in_file_name,
                                                 output_gff_file_name =>
                                                   $out_gff_file_name,
                                                 executable_path => $exec_path,
                                                 gff_source_name =>
                                                   $source_name,
                                                 non_aligned_file_name =>
                                                   $non_aligned_file_name,
                                                 database_file_name =>
                                                   $database_file_name);
 Function: Run a SSAHA search for the given input file against a fasta database
 Args    : input_file_name - the fasta file of reads
           output_gff_file_name - the output gff3 file path name
           executable_path - full path to the SSAHA executable
           gff_source_name - the value to use for the source field in the ouuput
           database_file_name - the full path to the target database
           non_aligned_file_name - a fasta file of sequences that don't align
              to the target
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my %params = validate(@_, { executable_path => 1,
                              input_file_name => 1,
                              database_file_name => 1,
                              gff_source_name => 1,
                              output_gff_file_name => 1,
                              non_aligned_file_name => 0
                            });

  my $in_file = $params{input_file_name};

  my $seqio = Bio::SeqIO->new(-file => $params{input_file_name} ,
                              -format => 'Fasta');

  my %fasta_counts = ();

  while (my $seq = $seqio->next_seq()) {
    if ($seq->desc() =~ /count:(\d+)/) {
      $fasta_counts{$seq->id()} = $1;
    }
  }

  my %matching_sequences = ();

  open my $output_gff_file, '>', $params{output_gff_file_name}
    or die "can't open $params{output_gff_file_name} for writing: $!\n";

  print $output_gff_file "##gff-version 3\n";

  if (!-e $params{database_file_name}) {
    croak "bad configuration: ssaha database file does not exist: ",
      $params{database_file_name}, "\n";
  }

  my $ssaha_command =
    "$params{executable_path} $in_file $params{database_file_name} $SSAHA_ARGS";

  my $username = getlogin();
  open my $ssaha_out, "$ssaha_command 2>> /tmp/SSAHASearchProcess.$username.log |"
    or die "can't open pipe to $params{executable_path}: $!";

  my $parser = SmallRNA::Parse::SSAHA->new(input_file_handle => $ssaha_out,
                                           format => 'standard');

  while (defined (my $match = $parser->next())) {
    my $seq_length = length $match->{qid};
    if ($match->{qstart} != 1 || $match->{qend} != $seq_length) {
      next;
    }

    if ($params{non_aligned_file_name}) {
      $matching_sequences{$match->{qid}}++;
    }

    _write($output_gff_file, $params{gff_source_name},
           $match, $fasta_counts{$match->{qid}});
  }

  close $ssaha_out or croak "failed to close command pipe: $! (exit code $?)";

  if (defined $output_gff_file) {
    close $output_gff_file;
  }

  if ($params{non_aligned_file_name}) {
    open my $non_aligned_file, '>', $params{non_aligned_file_name}
      or die "can't open $params{non_aligned_file_name} for writing: $!";

    for my $sequence (sort keys %fasta_counts) {
      if (!exists $matching_sequences{$sequence}) {
        print $non_aligned_file ">$sequence count:$fasta_counts{$sequence}\n";
        print $non_aligned_file "$sequence\n";
      }
    }

    close $non_aligned_file or die "failed to close file $params{non_aligned_file_name}: $!";
  }
}

1;
