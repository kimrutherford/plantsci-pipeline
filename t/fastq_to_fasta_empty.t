use strict;
use warnings;
use Test::More tests => 3;
use File::Temp qw(tempdir);

# test that removing adaptors generates an empty file rather than no file if
# there are no valid reads

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::TrimProcess';
}

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNATest;

my $config = SmallRNA::Config->new('t/test_config.yaml');
my $schema = SmallRNA::DB->new($config);
SmallRNATest::setup($schema, $config);

my $in_fastq_file = '/dev/null';

my $tempdir = tempdir("/tmp/remove_adaptors_test_$$.XXXXX", CLEANUP => 0);

my ($reject_file_name, $n_reject_file_name, $fasta_file_name, $output_file_name) =
  SmallRNA::Process::TrimProcess::run(
    output_dir_name => $tempdir,
    input_file_name => $in_fastq_file,
    processing_type => 'remove_adaptors',
    adaptor_sequence => 'TCGTATGCCGTCTTCTGCTTGT',
  );

ok(-s "$tempdir/$reject_file_name" == 0 , 'reject file size');
ok(-s "$tempdir/$output_file_name" == 0, 'output file size');
