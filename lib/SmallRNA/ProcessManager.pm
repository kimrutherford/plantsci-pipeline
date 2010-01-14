package SmallRNA::ProcessManager;

=head1 NAME

SmallRNA::ProcessManager - An in-memory store of the ProcessConf
                           configuration

=head1 SYNOPSIS

The class contains the logic for creating new pipeprocesses based on
the ProcessConfs in the database and the current contents of the
pipeprocess and pipedata tables.

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::ProcessManager

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
use Params::Validate qw(:all);
use Set::CrossProduct;

=head2 new

 Usage   : my $conf_store = SmallRNA::ProcessManager->new(schema => $schema);
 Function: Create and return a new ProcessManager object
 Args    : schema - the SmallRNA::DB object

=cut
sub new
{
  my $class = shift;
  my $self = { validate(@_, { schema => 1 }) };

  bless $self, $class;

  return $self;
}

sub _make_pipedata_constraint
{
  my ($conf, $input) = validate_pos(@_, 1, 1);

  my $content_type = $input->content_type();
  my $format_type = $input->format_type();
  my $content_type_id = undef;
  if (defined $content_type) {
    $content_type_id = $content_type->cvterm_id();
  }
  my $format_type_id = undef;
  if (defined $format_type) {
    $format_type_id = $format_type->cvterm_id();
  }
  my $conf_id = $conf->process_conf_id();

  my $content_constraint = '';
  my $format_constraint = '';

  if (defined $content_type_id) {
    $content_constraint = "AND content_type = $content_type_id"
  }

  if (defined $format_type_id) {
    $format_constraint = "AND format_type = $format_type_id";
  }

  return qq{
     NOT pipedata_id IN (
           SELECT pipeprocess_in_pipedata.pipedata
             FROM pipeprocess_in_pipedata, pipeprocess
            WHERE pipeprocess_in_pipedata.pipeprocess = pipeprocess.pipeprocess_id
              AND pipeprocess.process_conf = $conf_id
         )
$format_constraint
$content_constraint
  }
}

# Create a bit of SQL that constrains a Biosample to have inputs that
# match the given ProcessConfInput and which don't already have a Pipeprocess
# that uses the given ProcessConf
sub _make_bit
{
  my ($conf, $input) = validate_pos(@_, 1, 1);

  # biosamples where there is a pipedata of the appropriate type for this
  # input, but there isn't an existing pipeprocess for the process_conf

  my $org_constraint = '';

  if (defined $input->ecotype()) {
    my $organism_full_name = $input->ecotype()->organism()->full_name();
    $org_constraint =
      "AND me.biosample_id IN
        (SELECT biosample FROM biosample_ecotype, ecotype, organism
          WHERE biosample_ecotype.ecotype = ecotype.ecotype_id
            AND ecotype.organism = organism.organism_id
            AND organism.genus || ' ' || organism.species = '$organism_full_name')";
  }

  my $biosample_type_constraint = '';

  if (defined $input->biosample_type()) {
    my $biosample_type_name = $input->biosample_type()->name();
    $biosample_type_constraint =
      "AND me.biosample_type =
        (SELECT cvterm_id FROM cvterm WHERE cvterm.name = '$biosample_type_name')";
  }

  my $pipedata_constraint = _make_pipedata_constraint($conf, $input);

  return qq{
    me.biosample_id in (
      SELECT biosample_pipedata.biosample
        FROM biosample_pipedata, pipedata
       WHERE biosample_pipedata.pipedata = pipedata.pipedata_id
         AND $pipedata_constraint
         $org_constraint
         $biosample_type_constraint
    )
  };
}

# Find the sets of pipedatas from the biosample that can be input for the given
# process_conf.  The pipedatas are returned as a list of lists containing
# all combinations of pipedatas that can be input for the process.  For example
# if the process_conf needs two inputs one of type X and one Y, and we have
# two pipedatas of type X and two Ys in the biosample: x1, x2, y1, y2 then this
# function will return ((x1, y1), (x1, y2), (x2, y1), (x1, y2)).
sub _find_pipedata
{
  my ($biosample, $process_conf) = @_;

  my @results = ();

  my @inputs = $process_conf->process_conf_inputs();

  for my $input (@inputs) {
    my $content_type = $input->content_type();
    my $format_type = $input->format_type();

    my @matching_pipedatas = ();

    my $cond = { };

    if (defined $content_type) {
      $cond->{content_type} = $content_type->cvterm_id(),
    }
    if (defined $format_type) {
      $cond->{format_type} = $format_type->cvterm_id(),
    }

    my $matching_rs =
      $biosample->biosample_pipedatas()->search_related('pipedata', $cond);

    while (my $pipedata = $matching_rs->next()) {
      my @next_pipeprocess = $pipedata->next_pipeprocesses();

      if (grep {
        $_->process_conf()->process_conf_id() ==
          $process_conf->process_conf_id() } @next_pipeprocess) {
        # we're already run this process_conf for this pipedata
        next;
      }

      push @matching_pipedatas, $pipedata;
    }

    push @results, [@matching_pipedatas];
  }

  my $cross = Set::CrossProduct->new([@results]);

  if (@inputs == 1) {
    return map { [ $_] } @{$results[0]};
  } else {
    return $cross->combinations();
  }
}

sub _make_pipeprocess
{
  my ($schema, $process_conf, $input_pipedatas_ref) =
    validate_pos(@_, 1,1,1);

  my @input_pipedatas = @$input_pipedatas_ref;

  my $process_conf_name = $process_conf->type()->name();
  my $not_started_status = $schema->find_with_type('Cvterm', name => 'not_started');
  my $description = "processing with conf: $process_conf_name";

  if (defined $process_conf->detail()) {
    $description .= ', ' . $process_conf->detail();
  }

  my %pipeprocess_args = (
    description => $description,
    process_conf => $process_conf,
    status => $not_started_status
   );

  my $pipeprocess = $schema->create_with_type('Pipeprocess',
                                                {
                                                  %pipeprocess_args
                                                 }
                                               );

  for my $pipe_data (@input_pipedatas) {
    $pipeprocess->add_to_input_pipedatas($pipe_data);
  }

  $pipeprocess->update();

  return $pipeprocess;
}

# Create a all missing Pipeprocesses for the given process_conf and biosample
sub _create_biosample_proc
{
  my ($schema, $biosample, $process_conf, $existing_processes) =
    validate_pos(@_, (1) x 4);

  my @retlist = ();

  my @input_pipedata_sets = _find_pipedata($biosample, $process_conf);

  for my $input_pipedatas_ref (@input_pipedata_sets) {
    my @input_pipedatas = @{$input_pipedatas_ref};

    my $key = (join '_', map { $_->pipedata_id() } @input_pipedatas) . '_'
      . $process_conf->process_conf_id();

    if (exists $existing_processes->{$key}) {
      # we've created this process already, maybe because it's a remove adaptors
      # process for a multiplexed fastq file and we see the fastq file once per
      # biosample
      next;
    } else {
      $existing_processes->{$key} = 1;
    }

    push @retlist, _make_pipeprocess($schema, $process_conf, \@input_pipedatas);
  }

  return @retlist;
}

# Create pipeprocess entries for pipedatas that have a biosample (via the
# biosample_pipedata table).  We look at the problem biosample by biosample because if
# a process_conf has two inputs configured, they both must come from the same
# biosample.
sub _process_biosample_pipedata
{
  my $schema = shift;

  my $needs_processing_term =
    $schema->find_with_type('Cvterm', name => 'needs processing');

  my $process_conf_rs = $schema->resultset('ProcessConf');

  my @retlist = ();

  while (defined (my $process_conf = $process_conf_rs->next())) {
    my @inputs = $process_conf->process_conf_inputs();

    next unless @inputs > 0;

    my @where_bits = map {
      _make_bit($process_conf, $_);
    } @inputs;

    my $where = join ' AND ', @where_bits;
    $where .= ' AND processing_requirement = ' . $needs_processing_term->cvterm_id();

    my $rs = $schema->resultset('Biosample')->search({}, { where => $where });

    # keep a map so we don't create the same process twice, for example when
    # a fastq file contains more than one biosample - the query above will return
    # all the biosamples for the sequencing run corresponding to the fastq file,
    # all of which have the same fastq file as input
    my %existing_processes = ();

    while (my $biosample = $rs->next()) {
      push @retlist, _create_biosample_proc($schema, $biosample, $process_conf,
                                         \%existing_processes);
    }
  }

  return @retlist;
}

# Create pipeprocess entries for pipedatas that do not have a biosample (via the
# biosample_pipedata table).
sub _process_non_biosample_pipedata
{
  my $schema = shift;

  my $needs_processing_term =
    $schema->find_with_type('Cvterm', name => 'needs processing');

  my $needs_processing_term_id = $needs_processing_term->cvterm_id();

  my $process_conf_rs = $schema->resultset('ProcessConf');

  my @retlist = ();

  while (defined (my $process_conf = $process_conf_rs->next())) {
    my @inputs = $process_conf->process_conf_inputs();

    if (@inputs == 1) {
      my $pipedata_constraint = _make_pipedata_constraint($process_conf, $inputs[0]);
      # ignore pipedatas that have a biosample - those are handled by
      # _process_biosample_pipedata()
      $pipedata_constraint .= qq{
 AND pipedata_id NOT IN (SELECT pipedata FROM biosample_pipedata)
      };
      my $constraint = { where => $pipedata_constraint };
      my $rs = $schema->resultset('Pipedata')->search({}, $constraint);

      while (defined (my $pipedata = $rs->next())) {
        push @retlist, _make_pipeprocess($schema, $process_conf, [$pipedata]);
      }
    } else {
      # a process_conf with more than one input must be for pipedatas that have
      # a biosample
    }
  }

  return @retlist;
}

=head2 create_new_pipeprocesses

 Usage   : my @pipeprocess = $manager->create_new_pipeprocesses();
 Function: Create new pipeprocess objects and return all pipeprocesses
           that can be run given the current process_conf table.  We create a
           new pipeprocess when there are pipedata objects that are valid inputs
           for a ProcessConf and which don't have an existing pipe_process.
 Args    : none

=cut
sub create_new_pipeprocesses
{
  my ($self) = validate_pos(@_, 1);

  my $schema = $self->{schema};

  my @retlist = ();

  # we query each ProcessConf object then:
  #   - find all biosamples that have pipedata objects that are possible inputs for
  #     the ProcessConf and that do not have an existing pipeprocess with the
  #     pipedata as input
  #   - for each biosample we found, create any pipeprocesses that are needed

  my $code = sub {
    push @retlist, _process_biosample_pipedata($schema);
    push @retlist, _process_non_biosample_pipedata($schema);
  };

  $schema->txn_do($code);

  return @retlist;
}

1;
