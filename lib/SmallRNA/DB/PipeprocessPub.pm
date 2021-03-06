package SmallRNA::DB::PipeprocessPub;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("pipeprocess_pub");
__PACKAGE__->add_columns(
  "pipeprocess_pub_id",
  {
    data_type => "integer",
    default_value => "nextval('pipeprocess_pub_pipeprocess_pub_id_seq'::regclass)",
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
  "pipeprocess_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "pub_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("pipeprocess_pub_id");
__PACKAGE__->add_unique_constraint("pipeprocess_pub_id_pk", ["pipeprocess_pub_id"]);
__PACKAGE__->belongs_to(
  "pipeprocess",
  "SmallRNA::DB::Pipeprocess",
  { pipeprocess_id => "pipeprocess_id" },
);
__PACKAGE__->belongs_to("pub", "SmallRNA::DB::Pub", { pub_id => "pub_id" });


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SGkTzFn3/M7oyot04L5qlA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
