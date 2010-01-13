package SmallRNA::DB::SampleDbxref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("sample_dbxref");
__PACKAGE__->add_columns(
  "sample_dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sample_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "dbxref_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->belongs_to("dbxref", "SmallRNA::DB::Dbxref", { dbxref_id => "dbxref_id" });
__PACKAGE__->belongs_to("sample", "SmallRNA::DB::Sample", { sample_id => "sample_id" });


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:c5uVUGxpSysoq79sfSLPLA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
