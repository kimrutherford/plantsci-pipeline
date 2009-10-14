# test trimming with no offset from the start of the read and no multiplexing

use strict;
use warnings;
use Test::More tests => 7;
use File::Temp qw(tempdir);

use Test::Files;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::TrimProcess';
  use_ok 'SmallRNA::Runable::TrimRunable';
}

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNATest;

my $in_fastq_file = 't/data/SL283_H3.090805.42L0HAAXX.s_3.fq';

my $tempdir = tempdir("/tmp/remove_adapters_test_$$.XXXXX", CLEANUP => 0);

my $config = SmallRNA::Config->new('t/test_config.yaml');
my $schema = SmallRNA::DB->schema($config);
SmallRNATest::setup($schema, $config);

my ($reject_file_name, $fasta_file_name, $output) =
  SmallRNA::Process::TrimProcess::run(
    output_dir_name => $tempdir,
    input_file_name => $in_fastq_file,
    processing_type => 'trim',
#    trim_offset => 0
  );

ok(-s "$tempdir/$reject_file_name");

is($output, 'SL283_H3.090805.42L0HAAXX.s_3.fasta');

compare_ok($tempdir . '/' . $output, "t/data/fastq_to_fasta_trim_results/SL283_H3.090805.42L0HAAXX.s_3.fasta");
compare_ok($tempdir . '/' . $fasta_file_name, "t/data/fastq_to_fasta_trim_results/SL283_H3.090805.42L0HAAXX.s_3.reads.fasta");
compare_ok($tempdir . '/' . $reject_file_name, "t/data/fastq_to_fasta_trim_results/SL283_H3.090805.42L0HAAXX.s_3.rejects.fasta");
