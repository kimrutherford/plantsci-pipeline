package SmallRNA::DB::BiosampleDbxref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("biosample_dbxref");
__PACKAGE__->add_columns(
  "biosample_dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "biosample_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->belongs_to(
  "biosample",
  "SmallRNA::DB::Biosample",
  { biosample_id => "biosample_id" },
);
__PACKAGE__->belongs_to("dbxref", "SmallRNA::DB::Dbxref", { dbxref_id => "dbxref_id" });


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xqOhHE4wvAO1F1pUs+qEcg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
