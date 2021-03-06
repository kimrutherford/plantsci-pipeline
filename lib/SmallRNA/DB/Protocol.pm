package SmallRNA::DB::Protocol;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("protocol");
__PACKAGE__->add_columns(
  "protocol_id",
  {
    data_type => "integer",
    default_value => "nextval('protocol_protocol_id_seq'::regclass)",
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
  "name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("protocol_id");
__PACKAGE__->add_unique_constraint("protocol_id_pk", ["protocol_id"]);
__PACKAGE__->add_unique_constraint("protocol_name_key", ["name"]);
__PACKAGE__->has_many(
  "biosamples",
  "SmallRNA::DB::Biosample",
  { "foreign.protocol" => "self.protocol_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XpRGbCIBOx2NWOdcAk0QvA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
