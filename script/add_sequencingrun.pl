#!/usr/bin/perl -w

use strict;

use warnings;

use DateTime;

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNA::DBLayer::Loader;

if (@ARGV != 3) {
  die <<"EOF";
error: needs three arguments

usage:
  $0 <sequencing_centre_short_name> <biosample_identifier> <sequencing_run_identifier>
EOF
}

my $connect_string = SmallRNA::Config->db_connect_string();

my $username = SmallRNA::Config->db_username();
my $password = SmallRNA::Config->db_password();

my $schema = SmallRNA::DB->connect($connect_string, $username, $password);

my $sequencingcentre_short_name = shift;
my $biosample_identifier = shift;
my $sequencing_run_identifier = shift;

my $biosample_rs = $schema->resultset('Biosample');
my $biosample = $biosample_rs->find({
                               name => $biosample_identifier
                              });

if (!defined $biosample) {
  die "couldn't find biosample with name: $biosample_identifier\n";
}

my $sequencingtype = $schema->find_with_type('Cvterm', 'name', 'Illumina');

my $sequencingcentre = $schema->find_with_type('Organisation', 'name',
                                               $sequencingcentre_short_name);

my $sequencing_rs = $schema->resultset('Sequencingrun');

$sequencing_rs->create({
                        identifier => $sequencing_run_identifier,
                        biosample => $biosample,
                        submissiondate => DateTime->now(),
                        sequencingtype => $sequencingtype,
                        sequencingcentre => $sequencingcentre
                       });
