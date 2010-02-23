package SmallRNA::DB::SequencingSample;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("sequencing_sample");
__PACKAGE__->add_columns(
  "sequencing_sample_id",
  {
    data_type => "integer",
    default_value => "nextval('sequencing_sample_sequencing_sample_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "sequencing_centre_identifier",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "sample_creator",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("sequencing_sample_id");
__PACKAGE__->add_unique_constraint(
  "sequencing_sample_sequencing_centre_identifier_key",
  ["sequencing_centre_identifier"],
);
__PACKAGE__->add_unique_constraint("sequencing_sample_name_key", ["name"]);
__PACKAGE__->add_unique_constraint("sequencing_sample_id_pk", ["sequencing_sample_id"]);
__PACKAGE__->has_many(
  "libraries",
  "SmallRNA::DB::Library",
  { "foreign.sequencing_sample" => "self.sequencing_sample_id" },
);
__PACKAGE__->has_many(
  "sequencing_runs",
  "SmallRNA::DB::SequencingRun",
  { "foreign.sequencing_sample" => "self.sequencing_sample_id" },
);
__PACKAGE__->belongs_to(
  "sample_creator",
  "SmallRNA::DB::Person",
  { person_id => "sample_creator" },
);


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:l/KPNIrnraU+nWdD+7im8A

=head2 display_name

 Usage   : my $is_multiplexed = $seq_samp->is_multiplexed()
 Function: return true if and only if this sample is a multiplex of more than
           one library

=cut
sub is_multiplexed {
  my $self = shift;

  my @libraries = $self->libraries();

  if (@libraries > 1) {
    return 1;
  }
}

=head2 display_name

 Usage   : my $has_barcoded_libraries = $seq_samp->has_barcoded_libraries()
 Function: return true if and only if this sample contains one or more libraries
           that have been barcoded

=cut
sub has_barcoded_libraries {
  my $self = shift;

  my @libraries = $self->libraries();

  for my $library (@libraries) {
    if (defined $library->barcode()) {
      return 1;
    }
  }

  return 0;
}


# You can replace this text with custom content, and it will be preserved on regeneration
1;
