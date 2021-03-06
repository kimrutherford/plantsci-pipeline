package SmallRNA::DB::Person;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("person");
__PACKAGE__->add_columns(
  "person_id",
  {
    data_type => "integer",
    default_value => "nextval('person_person_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "created_stamp",
  {
    data_type => "timestamp without time zone",
    default_value => "now()",
    is_nullable => 0,
    size => 8,
  },
  "first_name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "last_name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "username",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "password",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "role",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "organisation",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("person_id");
__PACKAGE__->add_unique_constraint("person_id_pk", ["person_id"]);
__PACKAGE__->add_unique_constraint("person_username_key", ["username"]);
__PACKAGE__->add_unique_constraint("person_full_name_constraint", ["first_name", "last_name"]);
__PACKAGE__->has_many(
  "biosamples",
  "SmallRNA::DB::Biosample",
  { "foreign.biosample_creator" => "self.person_id" },
);
__PACKAGE__->belongs_to("role", "SmallRNA::DB::Cvterm", { cvterm_id => "role" });
__PACKAGE__->belongs_to(
  "organisation",
  "SmallRNA::DB::Organisation",
  { organisation_id => "organisation" },
);
__PACKAGE__->has_many(
  "pipeprojects",
  "SmallRNA::DB::Pipeproject",
  { "foreign.owner" => "self.person_id" },
);
__PACKAGE__->has_many(
  "sequencing_samples",
  "SmallRNA::DB::SequencingSample",
  { "foreign.sample_creator" => "self.person_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aSHBdDqtkIYNrZFtOnulKg

sub full_name {
  my $self = shift;

  return $self->first_name() . ' ' . $self->last_name();
}

1;
