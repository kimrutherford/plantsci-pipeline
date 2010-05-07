package SmallRNA::Runable::GenomeMatchingReadsRunable;

=head1 NAME

SmallRNA::Runable::GenomeMatchingReadsRunable - Read a GFF3 file and create
                            files containing only genome matching reads

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::GenomeMatchingReadsRunable

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
use Moose;
use Carp;

use Bio::SeqIO;

extends 'SmallRNA::Runable::SmallRNARunable';

=head2

 Function: Run GenomeMatchingReadsProcess for this Runable/pipeprocess
           and store the name of the resulting files in the pipedata table.
 Returns : nothing - either succeeds or calls die()

=cut
sub run
{
  my $self = shift;
  my $schema = $self->schema();

  my $code = sub {
    my $fasta_term_name = 'fasta';
    my $tsv_term_name = 'tsv';
    my $pipeprocess = $self->pipeprocess();

    my @input_pipedatas = $pipeprocess->input_pipedatas();
    if (@input_pipedatas != 1) {
      croak ("pipeprocess ", $pipeprocess->pipeprocess_id(),
             " must have one input pipedata\n");
    }

    my $gff_data = $input_pipedatas[0];

    my $data_dir = $self->config()->data_directory();

    my $gff_file_name = $data_dir . '/' . $gff_data->file_name();

    my $gff_content_type = $gff_data->content_type()->name();
    my $gff_format_type = $gff_data->format_type()->name();

    my $out_content_type = $gff_content_type;
    my $redundant_out_content_type = "redundant_$gff_content_type";

    my $fasta_out_file_name = $gff_file_name;
    my $redundant_fasta_out_file_name = $gff_file_name;
    my $tsv_out_file_name = $gff_file_name;

    my $old_suffix = ".$gff_format_type";

    my $new_suffix = ".$out_content_type.$fasta_term_name";
    $fasta_out_file_name =~ s/(\Q$old_suffix\E)?$/$new_suffix/;

    $new_suffix = ".$redundant_out_content_type.$fasta_term_name";
    $redundant_fasta_out_file_name =~ s/(\Q$old_suffix\E)?$/$new_suffix/;

    $new_suffix = ".$out_content_type.$tsv_term_name";
    $tsv_out_file_name =~ s/(\Q$old_suffix\E)?$/$new_suffix/;

    SmallRNA::Process::GenomeMatchingReadsProcess::run(
                     input_gff3_file_name => $gff_file_name,
                     fasta_output_file_name => $fasta_out_file_name,
                     redundant_fasta_output_file_name =>
                       $redundant_fasta_out_file_name,
                     tsv_output_file_name => $tsv_out_file_name);

    my @gff_properties = $gff_data->pipedata_properties();

    my %props_map = ();

    for my $gff_property (@gff_properties) {
      if ($gff_property->type()->name() =~ /^alignment .*/) {
        $props_map{$gff_property->type()->name()} = $gff_property->value();
      }
    }

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $fasta_out_file_name,
                          format_type_name => $fasta_term_name,
                          content_type_name => $out_content_type,
                          properties => \%props_map);

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $redundant_fasta_out_file_name,
                          format_type_name => $fasta_term_name,
                          content_type_name => $redundant_out_content_type,
                          properties => \%props_map);

    $self->store_pipedata(generating_pipeprocess => $self->pipeprocess(),
                          file_name => $tsv_out_file_name,
                          format_type_name => $tsv_term_name,
                          content_type_name => $out_content_type,
                          properties => \%props_map);
  };
  $self->schema->txn_do($code);
}

1;

