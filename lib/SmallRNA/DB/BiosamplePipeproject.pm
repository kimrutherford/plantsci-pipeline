package SmallRNA::DB::BiosamplePipeproject;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("biosample_pipeproject");
__PACKAGE__->add_columns(
  "biosample_pipeproject_id",
  {
    data_type => "integer",
    default_value => "nextval('biosample_pipeproject_biosample_pipeproject_id_seq'::regclass)",
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
  "pipeproject",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("biosample_pipeproject_id");
__PACKAGE__->add_unique_constraint(
  "biosample_pipeproject_constraint",
  ["biosample", "pipeproject"],
);
__PACKAGE__->add_unique_constraint("biosample_pipeproject_id_pk", ["biosample_pipeproject_id"]);
__PACKAGE__->belongs_to(
  "pipeproject",
  "SmallRNA::DB::Pipeproject",
  { pipeproject_id => "pipeproject" },
);
__PACKAGE__->belongs_to(
  "biosample",
  "SmallRNA::DB::Biosample",
  { biosample_id => "biosample" },
);


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sXAqsJyTVCXZT7EKBGvZ0A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
