package SmallRNA::Process::SAMToBAMProcess;

=head1 NAME

SmallRNA::Process::SAMToBAMProcess - Convert a SAM file to a BAM file

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::SAMToBAMProcess

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
use File::Temp qw(tempfile);
use File::Copy;

use Bio::SeqIO;

use SmallRNA::Process::Utils qw(do_system);

=head2 run

 Usage   : SmallRNA::Process::SAMToBAMProcess(input_file_name => $in_file_name,
                                              output_file_name =>
                                                 $output_file_name,
                                              samtools_path => $samtools_path,
                                              database_file_name =>
                                                 $database_file_name);
 Function: Run a BWA search for the given input file against a fasta database
 Args    : input_file_name - the SAM file name
           output_file_name - the output BAM file name
           samtools_path - full path to the samtools executable
           database_file_name - the full path to the target database
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my %params = validate(@_, { samtools_path => 1,
                              input_file_name => 1,
                              database_file_name => 1,
                              output_file_name => 1,
                            });

  my $infile_name = $params{input_file_name};
  my $outfile_name = $params{output_file_name};

  my $log_file_name = "/tmp/samtools_process.log";

  my $samtools_command =
    "$params{samtools_path} view -bt $params{database_file_name}.fai $infile_name";

  do_system "$samtools_command 2>> $log_file_name > $outfile_name";

  my ($fh, $sort_temp_file) =
    tempfile('/tmp/samtools_sort.XXXXXX', UNLINK => 1);

  my $sort_command =
    "$params{samtools_path} sort $outfile_name $sort_temp_file";

  do_system "$sort_command 2>> $log_file_name";

  move("$sort_temp_file.bam", $outfile_name);

  my $index_command =
    "$params{samtools_path} index $outfile_name";

  do_system "$index_command 2>> $log_file_name";
}

1;
