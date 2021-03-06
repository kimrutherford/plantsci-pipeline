package SmallRNA::DB::Tissue;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("tissue");
__PACKAGE__->add_columns(
  "tissue_id",
  {
    data_type => "integer",
    default_value => "nextval('tissue_tissue_id_seq'::regclass)",
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
  "organism",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("tissue_id");
__PACKAGE__->add_unique_constraint("tissue_id_pk", ["tissue_id"]);
__PACKAGE__->has_many(
  "biosamples",
  "SmallRNA::DB::Biosample",
  { "foreign.tissue" => "self.tissue_id" },
);
__PACKAGE__->belongs_to(
  "organism",
  "SmallRNA::DB::Organism",
  { organism_id => "organism" },
);


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aaHSKelmY2NyY47aWlPQbg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
