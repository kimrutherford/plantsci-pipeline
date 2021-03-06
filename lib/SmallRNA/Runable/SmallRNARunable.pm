package SmallRNA::Runable::SmallRNARunable;

=head1 NAME

SmallRNA::Runable::SmallRNARunable - A RunableI specialised for the SmallRNA
                                     pipeline

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Runable::SmallRNARunable

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
use warnings;
use Moose;
use Carp;
use File::Path;
use Params::Validate qw(:all);

with 'SmallRNA::RunableI';

has 'schema' => (is => 'ro', isa => 'SmallRNA::DB', required => 1);
has 'config' => (is => 'ro', required => 1);
has 'pipeprocess' => (is => 'ro', isa => 'SmallRNA::DB::Pipeprocess',
                      required => 1);

sub input_files
{
  my $self = shift;

  my @ret_files = ();
  my $process = $self->pipeprocess();
  my @input_pipedatas = $process->input_pipedatas();

  for my $pipedata (@input_pipedatas) {
    push @ret_files, $pipedata->file_name();
  }

  return @ret_files;
}

=head2

 Function: Store a file name in the pipedata table.
 Args    : generating_pipeprocess - the pipeprocess object that represents the
             process that generated this file; stored in the pipedata object
           file_name - the file to add
           format_type_name - the cvterm name of the format of the file
           content_type_name - the cvterm name of the content type of the file
           biosamples - a list of the biosample(s) that this pipedata comes from, or
             empty list if we should use the biosamples from the input pipedata
             for the generating_pipeprocess
           properties - a hash of property type (from the cvterm table) to
             property value (any string), which will be stored in the
             pipedata_property table
 Returns : nothing - either succeeds or calls die()

=cut
sub store_pipedata
{
  my $self = shift;

  my %params = validate(@_, { generating_pipeprocess => 1,
                              file_name => 1,
                              format_type_name => 1,
                              content_type_name => 1,
                              biosamples => 0,
                              properties => 0,
                            });

  my $schema = $self->schema();

  my $format_term =
    $schema->find_with_type('Cvterm', name => $params{format_type_name});
  my $content_term =
    $schema->find_with_type('Cvterm', name => $params{content_type_name});

  my %pipedata_properties = ();

  if (defined $params{properties}) {
    %pipedata_properties = %{$params{properties}};
  }

  my $file_name = $params{file_name};

  my $data_dir = $self->config()->data_directory();

  $file_name =~ s|$data_dir/*||;

  my $full_file_name = "$data_dir/$file_name";

  if (!-e $full_file_name) {
    croak "error: tried to store a file that doesn't exist: $file_name\n";
  }

  my $file_length = -s $full_file_name;

  my $pipedata_args = {
                       generating_pipeprocess => $params{generating_pipeprocess},
                       file_name => $file_name,
                       format_type => $format_term,
                       content_type => $content_term,
                       file_length => -s $full_file_name,
                      };
  my $pipedata = $schema->create_with_type('Pipedata', $pipedata_args);

  if (defined $params{biosamples}) {
    map { $pipedata->add_to_biosamples($_); } @{$params{biosamples}};
  } else {
    my @prev_pipedata =
      $params{generating_pipeprocess}->pipeprocess_in_pipedatas()->search_related('pipedata');
    my @prev_biosamples = map { $_->biosamples() } @prev_pipedata;
    map { $pipedata->add_to_biosamples($_); } @prev_biosamples;
  }

  $pipedata->update();

  for my $prop_type_name (sort keys %pipedata_properties) {
    my $type_cvterm = $schema->find_with_type('Cvterm', name => $prop_type_name);
    my $create_args = {
      type => $type_cvterm,
      value => $pipedata_properties{$prop_type_name},
      pipedata => $pipedata
    };
    $schema->create_with_type('PipedataProperty', $create_args);
  }

  return $pipedata;
}

sub get_pipeprocess_details
{
  my $self = shift;
  my $pipeprocess = shift;

  my @input_pipedatas = $pipeprocess->input_pipedatas();
  my $pipeprocess_id = $pipeprocess->pipeprocess_id();

  if (@input_pipedatas > 1) {
    croak ("pipeprocess ", $pipeprocess_id,
           " has more than one input pipedata\n");
  }

  my $input_pipedata = $input_pipedatas[0];

  my @biosamples = $input_pipedata->biosamples();

  if (@biosamples != 1) {
    croak("pipedata has more than one biosample, can't continue: ",
          $input_pipedata->file_name(), "\n");
  }

  my $biosample = $biosamples[0];

  my $process_conf = $pipeprocess->process_conf();
  my $detail = $process_conf->detail();

  my @process_conf_inputs = $process_conf->process_conf_inputs();

  if (@process_conf_inputs != 1) {
    croak("process conf for process #", $pipeprocess_id,
          " has more than one input configured\n");
  }

  my $org_full_name;

  if (defined $detail && $detail =~ /target: "([^"]+)"/) {
    $org_full_name = $1;
  } else {
    my $target_organism = $process_conf_inputs[0]->ecotype()->organism();
    $org_full_name = $target_organism->full_name();
  }

  $org_full_name =~ s/ /_/g;

  my $database_conf = $self->config()->{databases};

  my $org_config = $database_conf->{organisms}{$org_full_name};

  if (!defined $org_config) {
    croak("no configuration found for $org_full_name for process #",
          $pipeprocess_id, "\n");
  }

  if (!defined $org_config) {
    croak "can't find organism configuration for ", $biosample->name(), "\n";
  }

  my $component = undef;

  for my $prop ($input_pipedata->pipedata_properties()) {
    if ($prop->type()->name() eq 'alignment component') {
      $component = $prop->value();
    }
  }

  if (defined $detail && $detail =~ /component: ([^,]+)/) {
    if (defined $component) {
      croak "inconsistent configuration - pipedata ", $input_pipedata->pipedata_id(),
        " has an 'alignment component' and the pipeprocess has a 'component:' detail";
    } else {
      $component = $1;
    }
  }

  if (!defined $component) {
    croak ("can't find alignment component for pipeprocess: ", $pipeprocess_id);
  }

  if (!defined $org_config->{database_files}{$component}) {
    die "can't find configuration for component: $component\n";
  }

  return ($org_full_name, $component,
          $database_conf->{root} . '/' . $org_config->{database_files}{$component});
}

sub run
{
  croak "you must implement this method in a sub-class\n";
}

1;
