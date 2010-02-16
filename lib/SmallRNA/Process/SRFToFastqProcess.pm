package SmallRNA::Process::SRFToFastqProcess;

=head1 NAME

SmallRNA::Process::SRFToFastqProcess - convert an SRF file into a FastQ file

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::SRFToFastqProcess

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

use SmallRNA::Process::Utils qw(do_system);

=head2

 Usage   : SmallRNA::Process::SRFToFastqProcess::run(exec_path => 1,
                                                     input_file_name =>
                                                       $in_file_name,
                                                     output_file_name =>
                                                       $out_file_name);
 Function: Convert an SRF file to a FastQ file
 Args    : input_file_name - the input file name
           output_file_name - the name of the file to write the FastQ output to
           exec_path - full path to the srf2fastq executable
 Returns : nothing - either succeeds or calls croak()

=cut
sub run
{
  my %params = validate(@_, { input_file_name => 1, output_file_name => 1,
                              exec_path => 1 });

  my $infile_name = $params{input_file_name};
  my $outfile_name = $params{output_file_name};

  my $log_file_name = "/tmp/srf2fastq_process.log";

  if (!-e $infile_name) {
    croak "can't find input file: $infile_name}";
  }

  my $command = "$params{exec_path} -c $infile_name";

  do_system "$command 2>> $log_file_name > $outfile_name";
}

1;
