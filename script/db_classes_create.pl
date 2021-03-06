#!/usr/bin/perl -w

# recreate the DB classes by reading the database schema

BEGIN {
  push @INC, "lib";
}

use strict;

use SmallRNA::Config;

my $config_file_name = shift;
my $config = SmallRNA::Config->new($config_file_name);

my @connect_info = @{$config->{"Model::SmallRNAModel"}{connect_info}};

my ($connect_string, $username, $password) = @connect_info;

use DBIx::Class::Schema::Loader qw(make_schema_at);


# change the methods on the objects so we can say $cvterm->cv()
# rather than $cvterm->cv_id() to get the CV
sub remove_id {
  my $relname = shift;
  my $res = Lingua::EN::Inflect::Number::to_S($relname);
  $res =~ s/_id$//;
  return $res;
}

make_schema_at('SmallRNA::DB',
               { debug => 1, dump_directory => './lib', inflect_singular =>
                   \&remove_id },
               [ "$connect_string;password=$password", $username ]);


