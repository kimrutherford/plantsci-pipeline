use strict;
use warnings;
use Test::More tests => 2;

use File::Temp qw(tempfile);
use Test::Files;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::SizeFilterProcess';
}

my $input_file_name = 't/data/reads_fasta_summary_test.fasta';

my ($fh, $output_file_name) =
  tempfile('/tmp/size_filter_test.XXXXXX', UNLINK => 0);

my $res = SmallRNA::Process::SizeFilterProcess::run(
  output_file_name => $output_file_name,
  input_file_name => $input_file_name,
  min_size => 24
);

compare_ok($output_file_name, 't/data/expected_size_filter_output.fasta');
