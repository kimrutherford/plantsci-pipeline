package SmallRNA::Runable::SAMToBAMRunable;

=head1 NAME

SmallRNA::Runable::SAMToBAMRunable - Create a BAM file from a SAM file

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::SAMToBAMRunable

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the bame terms as Perl itself.

=head1 FUNCTIONS

=cut

use strict;
use warnings;
use Carp;

use Moose;

use SmallRNA::Process::SAMToBAMProcess;

extends 'SmallRNA::Runable::SmallRNARunable';

=head2

 Function: Create a BAM file from a SAM file
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my $self = shift;
  my $schema = $self->schema();

  my $code = sub {
    my $pipeprocess = $self->pipeprocess();

    my ($org_full_name, $component, $db_file_name) =
      $self->get_pipeprocess_details($pipeprocess);

    my @input_pipedatas = $pipeprocess->input_pipedatas();
    if (@input_pipedatas > 1) {
      croak ("pipeprocess ", $pipeprocess->pipeprocess_id(),
             " has more than one input pipedata\n");
    }
    my $input_pipedata = $input_pipedatas[0];

    my $input_format_type = $input_pipedata->format_type()->name();
    my $input_content_type = $input_pipedata->content_type()->name();

    if ($input_format_type ne 'sam') {
      croak("must have 'SAM' as input, not: , $input_format_type");
    }

    my $output_type = 'bam';
    my $data_dir = $self->config()->data_directory();

    my $input_file_name = $data_dir . '/' . $input_pipedata->file_name();

    my $output_file_name = $input_file_name;

    my $c = $self->config()->{programs}{samtools};
    my $samtools_path = $c->{path};

    warn "SAMToBAMRunable: ", $pipeprocess->pipeprocess_id(), "\n";

    if ($output_file_name =~ s/\.($input_format_type)$/.$1.$output_type/) {
      SmallRNA::Process::SAMToBAMProcess::run(input_file_name => $input_file_name,
                                              output_file_name => $output_file_name,
                                              samtools_path => $samtools_path,
                                              database_file_name =>
                                                $db_file_name);

      $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                            file_name => $output_file_name,
                            format_type_name => $output_type,
                            content_type_name => $input_content_type);
    } else {
      croak("pattern match failed on: ", $output_file_name);
    }
  };
  $self->schema->txn_do($code);
}

1;
