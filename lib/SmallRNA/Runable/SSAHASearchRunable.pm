package SmallRNA::Runable::SSAHASearchRunable;

=head1 NAME

SmallRNA::Runable::SSAHASearchRunable - Run, parse and save the results of a
                                        SSAHA search

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::SSAHASearchRunable

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

none - see SmallRNA::RunableI;

=cut

use strict;
use warnings;
use Carp;
use Mouse;

extends 'SmallRNA::Runable::AlignmentRunable';

=head2

 Function: Run the a SSAHA alignment and store the name of the resulting files
           in the pipedata table
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my $self = shift;
  my $schema = $self->schema();

  $self->run_alignment('ssaha');
}

1;

