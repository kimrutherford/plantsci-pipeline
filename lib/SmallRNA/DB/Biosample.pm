package SmallRNA::DB::Biosample;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("biosample");
__PACKAGE__->add_columns(
  "biosample_id",
  {
    data_type => "integer",
    default_value => "nextval('biosample_biosample_id_seq'::regclass)",
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
  "biosample_type",
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
__PACKAGE__->set_primary_key("biosample_id");
__PACKAGE__->add_unique_constraint("biosample_name_key", ["name"]);
__PACKAGE__->add_unique_constraint("biosample_id_pk", ["biosample_id"]);
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
__PACKAGE__->belongs_to("tissue", "SmallRNA::DB::Tissue", { tissue_id => "tissue" });
__PACKAGE__->belongs_to(
  "biosample_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "biosample_type" },
);
__PACKAGE__->belongs_to(
  "protocol",
  "SmallRNA::DB::Protocol",
  { protocol_id => "protocol" },
);
__PACKAGE__->belongs_to(
  "molecule_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "molecule_type" },
);
__PACKAGE__->belongs_to(
  "fractionation_type",
  "SmallRNA::DB::Cvterm",
  { cvterm_id => "fractionation_type" },
);
__PACKAGE__->has_many(
  "biosample_dbxrefs",
  "SmallRNA::DB::BiosampleDbxref",
  { "foreign.biosample_id" => "self.biosample_id" },
);
__PACKAGE__->has_many(
  "biosample_ecotypes",
  "SmallRNA::DB::BiosampleEcotype",
  { "foreign.biosample" => "self.biosample_id" },
);
__PACKAGE__->has_many(
  "biosample_pipedatas",
  "SmallRNA::DB::BiosamplePipedata",
  { "foreign.biosample" => "self.biosample_id" },
);
__PACKAGE__->has_many(
  "biosample_pipeprojects",
  "SmallRNA::DB::BiosamplePipeproject",
  { "foreign.biosample" => "self.biosample_id" },
);
__PACKAGE__->has_many(
  "libraries",
  "SmallRNA::DB::Library",
  { "foreign.biosample" => "self.biosample_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KjpTnsitonYdaZcbWBICnA

__PACKAGE__->many_to_many('pipedatas' => 'biosample_pipedatas', 'pipedata');
__PACKAGE__->many_to_many('ecotypes' => 'biosample_ecotypes', 'ecotype');
__PACKAGE__->many_to_many('pipeprojects' => 'biosample_pipeprojects', 'pipeproject');

my %_fasta_counts_cache = ();

my $_cache_time = undef;
my $MAX_CACHE_AGE = 10 * 60;  # 10 minutes

sub _populate_fasta_counts_cache
{
  my $schema = shift;

  my $query = <<"END";
SELECT biosample.name AS biosample_name,
       pipedata_content_type.name AS pipedata_content_type_name,
       property_type_cvterm.name AS property_type_name,
       pipedata_property.value AS prop_value
  FROM biosample
  LEFT JOIN biosample_pipedata on biosample_pipedata.biosample = biosample.biosample_id
  LEFT JOIN pipedata on biosample_pipedata.pipedata = pipedata.pipedata_id
  LEFT JOIN pipedata_property
               ON pipedata_property.pipedata = pipedata.pipedata_id
  LEFT JOIN cvterm pipedata_content_type
               ON pipedata_content_type.cvterm_id = pipedata.content_type
  LEFT JOIN cvterm property_type_cvterm
               ON property_type_cvterm.cvterm_id = pipedata_property.type
END

  my $start_time = time();

  my $dbh = $schema->storage()->dbh();
  my $sth = $dbh->prepare($query) || die $dbh->errstr;
  $sth->execute() || die $sth->errstr;

  while (my $r = $sth->fetchrow_hashref()) {
    my $biosample_name = $r->{biosample_name};
    my $pipedata_content_type_name = $r->{pipedata_content_type_name};
    my $property_type_name = $r->{property_type_name};
    my $prop_value = $r->{prop_value};

    if (defined $pipedata_content_type_name && defined $property_type_name) {
      $_fasta_counts_cache{$biosample_name}{$pipedata_content_type_name}{$property_type_name} = $prop_value;
    } else {
      if (!exists $_fasta_counts_cache{$biosample_name}) {
        # placeholder so that we know we've queried for this biosample before
        $_fasta_counts_cache{$biosample_name} = undef;
      }
    }
  }

  $_cache_time = time();
}

=head2 get_pipedata_property

 Function: Get a pipedata_property of a pipedata of a Biosample
 Args    : $biosample - the Biosample object
           $pipedata_content_type_name - the content type of the pipedata whose
              properties interest us
           $property_type_name - the property type to find
 Returns : the property value, or undef

=cut
sub get_pipedata_property
{
  my $biosample = shift;
  my $pipedata_content_type_name = shift;
  my $property_type_name = shift;

  my $biosample_name = $biosample->name();

  if (!exists $_fasta_counts_cache{$biosample_name} || 
      !defined $_cache_time ||
      (time() - $_cache_time > $MAX_CACHE_AGE)) {
    my $schema = $biosample->result_source->schema();
    _populate_fasta_counts_cache($schema);
  }

  return $_fasta_counts_cache{$biosample_name}{$pipedata_content_type_name}{$property_type_name};
}

1;
