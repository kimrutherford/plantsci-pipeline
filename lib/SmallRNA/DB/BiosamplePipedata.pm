package SmallRNA::DB::BiosamplePipedata;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("biosample_pipedata");
__PACKAGE__->add_columns(
  "biosample_pipedata_id",
  {
    data_type => "integer",
    default_value => "nextval('biosample_pipedata_biosample_pipedata_id_seq'::regclass)",
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
  "pipedata",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("biosample_pipedata_id");
__PACKAGE__->add_unique_constraint("biosample_pipedata_id_pk", ["biosample_pipedata_id"]);
__PACKAGE__->belongs_to(
  "biosample",
  "SmallRNA::DB::Biosample",
  { biosample_id => "biosample" },
);
__PACKAGE__->belongs_to(
  "pipedata",
  "SmallRNA::DB::Pipedata",
  { pipedata_id => "pipedata" },
);


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wBJAx0YSSzPYfgfX68Wb1Q

1;
