use strict;
use warnings;
use Test::More tests => 3;

use File::Temp qw(tempfile);

use SmallRNA::Config;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::SAMToBAMProcess';
}

my $input_file_name = 't/data/ssaha_search_results.sam';;

my $db_file_name = 't/data/arabidopsis_thaliana_test_genome.fasta';

my ($index_fh, $temp_output_file_name) =
  tempfile('/tmp/sam_to_bam_test.XXXXXX', UNLINK => 0);

my $config = SmallRNA::Config->new('t/test_config.yaml')->{programs}{samtools};

SmallRNA::Process::SAMToBAMProcess::run(input_file_name => $input_file_name,
                                        output_file_name => $temp_output_file_name,
                                        samtools_path => $config->{path},
                                        database_file_name => $db_file_name);

ok(-s $temp_output_file_name, 'has output');
ok(-s "$temp_output_file_name.bai", 'has index file');
