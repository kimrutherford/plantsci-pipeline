package SmallRNA::DB::Sample;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("sample");
__PACKAGE__->add_columns(
  "sample_id",
  {
    data_type => "integer",
    default_value => "nextval('sample_sample_id_seq'::regclass)",
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
  "genotype",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "description",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "protocol",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sample_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "molecule_type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "treatment_type",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "fractionation_type",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "processing_requirement",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "tissue",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("sample_id");
__PACKAGE__->add_unique_constraint("sample_name_key", ["name"]);
__PACKAGE__->add_unique_constraint("sample_id_pk", ["sample_id"]);
__PACKAGE__->has_many(
  "coded_samples",
  "SmallRNA::DB::CodedSample",
  { "foreign.sample" => "self.sample_id" },
);
__PACKAGE__->belongs_to("tissue", "SmallRNA::DB::Tissue", { tissue_id => "tissue" });
__PACKAGE__->belongs_to(
  "protocol",
  "SmallRNA::DB::Protocol",
  { protocol_id => "protocol" },
);
__PACKAGE__->belongs_to(
  "processing_requirement",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "processing_requirement" },
);
__PACKAGE__->belongs_to(
  "treatment_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "treatment_type" },
);
__PACKAGE__->belongs_to(
  "sample_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "sample_type" },
);
__PACKAGE__->belongs_to(
  "fractionation_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "fractionation_type" },
);
__PACKAGE__->belongs_to(
  "molecule_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "molecule_type" },
);
__PACKAGE__->has_many(
  "sample_dbxrefs",
  "SmallRNA::DB::SampleDbxref",
  { "foreign.sample_id" => "self.sample_id" },
);
__PACKAGE__->has_many(
  "sample_ecotypes",
  "SmallRNA::DB::SampleEcotype",
  { "foreign.sample" => "self.sample_id" },
);
__PACKAGE__->has_many(
  "sample_pipedatas",
  "SmallRNA::DB::SamplePipedata",
  { "foreign.sample" => "self.sample_id" },
);
__PACKAGE__->has_many(
  "sample_pipeprojects",
  "SmallRNA::DB::SamplePipeproject",
  { "foreign.sample" => "self.sample_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0gZyl41qMMv1eV1gIy74bg

__PACKAGE__->many_to_many('pipedatas' => 'sample_pipedatas', 'pipedata');
__PACKAGE__->many_to_many('ecotypes' => 'sample_ecotypes', 'ecotype');
__PACKAGE__->many_to_many('pipeprojects' => 'sample_pipeprojects', 'pipeproject');

my %_fasta_counts_cache = ();

sub _populate_fasta_counts_cache
{
  my $schema = shift;

  my $query = <<"END";
SELECT sample.name AS sample_name,
       pipedata_content_type.name AS pipedata_content_type_name,
       property_type_cvterm.name AS property_type_name,
       pipedata_property.value AS prop_value
  FROM sample
  LEFT JOIN sample_pipedata on sample_pipedata.sample = sample.sample_id
  LEFT JOIN pipedata on sample_pipedata.pipedata = pipedata.pipedata_id
  LEFT JOIN pipedata_property
               ON pipedata_property.pipedata = pipedata.pipedata_id,
            cvterm pipedata_content_type, cvterm property_type_cvterm
      WHERE property_type_cvterm.cvterm_id = pipedata_property.type
        AND pipedata_content_type.cvterm_id = pipedata.content_type
END

  my $start_time = time();

  my $dbh = $schema->storage()->dbh();
  my $sth = $dbh->prepare($query) || die $dbh->errstr;
  $sth->execute() || die $sth->errstr;

  while (my $r = $sth->fetchrow_hashref()) {
    my $sample_name = $r->{sample_name};
    my $pipedata_content_type_name = $r->{pipedata_content_type_name};
    my $property_type_name = $r->{property_type_name};
    my $prop_value = $r->{prop_value};

    next unless $sample_name =~ /SL107|SL113/;

    $_fasta_counts_cache{$sample_name}{$pipedata_content_type_name}{$property_type_name} = $prop_value;
  }
}

=head2 get_pipedata_property

 Function: Get a pipedata_property of a pipedata of a Sample
 Args    : $sample - the Sample object
           $pipedata_content_type_name - the content type of the pipedata whose
              properties interest us
           $property_type_name - the property type to find
 Returns : the property value, or undef

=cut
sub get_pipedata_property
{
  my $sample = shift;
  my $pipedata_content_type_name = shift;
  my $property_type_name = shift;

  my $sample_name = $sample->name();

  if (!exists $_fasta_counts_cache{$sample_name}) {
    my $schema = $sample->result_source->schema();
    _populate_fasta_counts_cache($schema);
  }

  return $_fasta_counts_cache{$sample_name}{$pipedata_content_type_name}{$property_type_name};
}

1;
