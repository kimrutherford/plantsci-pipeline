package SmallRNA::DB::BiosampleEcotype;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("biosample_ecotype");
__PACKAGE__->add_columns(
  "biosample_ecotype_id",
  {
    data_type => "integer",
    default_value => "nextval('biosample_ecotype_biosample_ecotype_id_seq'::regclass)",
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
  "biosample",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "ecotype",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("biosample_ecotype_id");
__PACKAGE__->add_unique_constraint("biosample_ecotype_id_pk", ["biosample_ecotype_id"]);
__PACKAGE__->add_unique_constraint("biosample_ecotype_constraint", ["biosample", "ecotype"]);
__PACKAGE__->belongs_to(
  "biosample",
  "SmallRNA::DB::Biosample",
  { biosample_id => "biosample" },
);
__PACKAGE__->belongs_to(
  "ecotype",
  "SmallRNA::DB::Ecotype",
  { ecotype_id => "ecotype" },
);


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nlacC4dDtgg/oHW8XxMpRw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
