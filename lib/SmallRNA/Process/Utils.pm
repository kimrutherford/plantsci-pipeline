package SmallRNA::Process::Utils;

=head1 NAME

SmallRNA::Process::Utils - utility methods for the Process package

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::Utils

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

use Exporter;

use vars qw(@ISA @EXPORT_OK);
@ISA = qw(Exporter);
@EXPORT_OK = qw(do_system);

=head2 do_system

 Usage   : SmallRNA::Process::Utils::do_system($command_with_arguments);
 Function: Run a command with system(), check the return code and call die()
           if the command failed
 Return  : nothing - either succeeds or calls die()
 Args    : $command_with_arguments - the string to pass to system()

=cut
sub do_system
{
  my $system_args = shift;

  my $retcode = system $system_args;

  if ($retcode != 0) {
    warn "system ($system_args) failed: $?\n";

    if ($? == -1) {
      warn "failed to execute: $!\n";
    }
    elsif ($? & 127) {
      printf STDERR "child died with signal %d, %s coredump\n",
        ($? & 127),  ($? & 128) ? 'with' : 'without';
    }
    else {
      printf STDERR "child exited with value %d\n", $? >> 8;
    }

    die "command failed - exiting $?\n";
  }
}

1;
