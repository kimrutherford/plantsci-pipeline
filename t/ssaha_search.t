use strict;
use warnings;
use Test::More tests => 1;
use File::Temp qw(tempfile);
use Test::Files;

use YAML;

use SmallRNA::Config;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::SSAHASearchProcess';
}

# disabled because ssaha v1 isn't currently available
__END__

my $input_file_name = 't/data/reads_fasta_summary_test.fasta';
my $db_file_name = 't/data/arabidopsis_thaliana_test_genome.fasta';

my ($gff_fh, $output_gff_file_name) =
  tempfile('/tmp/ssaha_search_test_gff.XXXXXX', UNLINK => 0);

my $config = SmallRNA::Config->new('t/test_config.yaml')->{programs}{ssaha};

my $res = SmallRNA::Process::SSAHASearchProcess::run(
  executable_path => $config->{path},
  database_file_name => $db_file_name,
  input_file_name => $input_file_name,
  gff_source_name => 'test_source',
  output_gff_file_name => $output_gff_file_name,
);

ok(-s $output_gff_file_name, 'has gff output');

compare_ok($output_gff_file_name, "t/data/ssaha_search_results.gff3",
           'gff results comparison');
