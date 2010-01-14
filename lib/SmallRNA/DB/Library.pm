package SmallRNA::DB::Library;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("library");
__PACKAGE__->add_columns(
  "library_id",
  {
    data_type => "integer",
    default_value => "nextval('library_library_id_seq'::regclass)",
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
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "library_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "biosample",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sequencing_sample",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "adaptor",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "barcode",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("library_id");
__PACKAGE__->add_unique_constraint("library_id_pk", ["library_id"]);
__PACKAGE__->belongs_to(
  "sequencing_sample",
  "SmallRNA::DB::SequencingSample",
  { sequencing_sample_id => "sequencing_sample" },
);
__PACKAGE__->belongs_to(
  "library_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "library_type" },
);
__PACKAGE__->belongs_to(
  "barcode",
  "SmallRNA::DB::Barcode",
  { barcode_id => "barcode" },
);
__PACKAGE__->belongs_to(
  "biosample",
  "SmallRNA::DB::Biosample",
  { biosample_id => "biosample" },
);
__PACKAGE__->belongs_to("adaptor", "SmallRNA::DB::Cvterm", { cvterm_id => "adaptor" });


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hC4pG8dieW4TCjAfXc8MvQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
