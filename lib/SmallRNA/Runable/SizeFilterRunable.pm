package SmallRNA::Runable::SizeFilterRunable;

=head1 NAME

SmallRNA::Runable::SizeFilterRunable - Filter sequences by size

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::SizeFilterRunable

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
use Mouse;

use SmallRNA::Process::SizeFilterProcess;

extends 'SmallRNA::Runable::SmallRNARunable';

=head2

 Function: Run TrimRunableProcess for this Runable/pipeprocess and store the
           name of the resulting files in the pipedata table.
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my $self = shift;
  my $schema = $self->schema();

  my $code = sub {
    my $pipeprocess = $self->pipeprocess();

    my $process_conf = $pipeprocess->process_conf();
    my $detail = $process_conf->detail();

    my @input_pipedatas = $pipeprocess->input_pipedatas();
    if (@input_pipedatas > 1) {
      croak ("pipeprocess ", $pipeprocess->pipeprocess_id(),
             " has more than one input pipedata\n");
    }
    my $input_pipedata = $input_pipedatas[0];

    my $input_format_type = $input_pipedata->format_type()->name();
    my $input_content_type = $input_pipedata->content_type()->name();

    if ($input_format_type ne 'fasta') {
      croak("must have 'fasta' as input, not: , $input_format_type");
    }

    my $data_dir = $self->config()->data_directory();
    my $input_file_name = $data_dir . '/' . $input_pipedata->file_name();
    my $output_file_name = $input_file_name;
    my $output_content_type = "filtered_$input_content_type";

    $output_file_name =~ s/\.([^\.]*).(fa|fasta)$/.filtered_$1.fasta/;

    if ($detail =~ /min_size: (\S+)/) {
      SmallRNA::Process::SizeFilterProcess::run(input_file_name => $input_file_name,
                                                output_file_name => $output_file_name,
                                                min_size => $1);

      $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                            file_name => $output_file_name,
                            format_type_name => 'fasta',
                            content_type_name => $output_content_type);
    } else {
      croak("no min_size specified in details for process_conf: ",
            $process_conf->process_conf_id());
    }
  };
  $self->schema->txn_do($code);
}

1;
