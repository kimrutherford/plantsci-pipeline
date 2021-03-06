package SmallRNA::PipeWork;

=head1 NAME

SmallRNA::PipeWork - Helper code used by the worker process

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::PipeWork

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
use Params::Validate;

=head2

 Usage   : SmallRNA::PipeWork::run_process(schema => $schema, config => $config,
                                           pipeprocess => $pipeprocess);
 Function: run the Runable for a pipeprocess
 Args    : schema - the schema to update
           config - a SmallRNA::Config object
           pipeproces - the process to run
 Returns : nothing - either succeeds or calls die()

=cut
sub run_process
{
  my %params = validate(@_, { schema => 1, config => 1, pipeprocess => 1 });
  my $schema = $params{schema};
  my $config = $params{config};
  my $pipeprocess = $params{pipeprocess};

  my $conf = $pipeprocess->process_conf();
  my $runable_name = $conf->runable_name();

  # it would be nice to do this without eval:
  eval "require $runable_name";
  if ($@) {
    return ('failed', "$runable_name->run() failed with error: $@");
  }

  eval {
    my $runable = $runable_name->new(schema => $schema,
                                     config => $config,
                                     pipeprocess => $pipeprocess);
    $runable->run();
  };
  if ($@) {
    return ('failed', "$runable_name->run() failed with error: $@");
  }

  return ('finished', '');
}

1;
