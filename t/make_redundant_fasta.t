use strict;
use warnings;
use autodie;

use Test::More tests => 3;
use File::Temp qw(tempdir);
use File::Compare;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::MakeRedundantFastaProcess';
}


my $input_file_name = 't/data/non_redundant_srna_SL234_B.fasta';

my $tempdir = tempdir("/tmp/make_redundant_reads_test_$$.XXXXX", CLEANUP => 0);

my $output_file_name = "$tempdir/redundant_reads.fasta";

SmallRNA::Process::MakeRedundantFastaProcess::run(
  input_file_name => $input_file_name,
  output_file_name => $output_file_name
);

ok(-s $output_file_name, 'output file size');
ok(compare($output_file_name, "t/data/make_redundant_output_srna_SL234_B.fasta") == 0);
