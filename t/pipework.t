use strict;
use warnings;
use Test::More tests => 264;
use DateTime;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Runable::SmallRNARunable';
}

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNA::ProcessManager;
use SmallRNATest;
use SmallRNA::PipeWork;

my $config = SmallRNA::Config->new('t/test_config.yaml');

my $schema = SmallRNA::DB->new($config);

# create database and test directories
SmallRNATest::setup($schema, $config);

my $process_manager = SmallRNA::ProcessManager->new(schema => $schema);

my $queued_status = $schema->find_with_type('Cvterm', name => 'queued');
my $started_status = $schema->find_with_type('Cvterm', name => 'started');

for (my $i = 0; $i < 7; $i++) {
  # this is a faked version of pipeserv.pl
  #  - queue each not_started pipeprocess
  my @processes = $process_manager->create_new_pipeprocesses();

  my $pipeprocess_rs = $schema->resultset('Pipeprocess')->search();

  while (my $pipeprocess = $pipeprocess_rs->next()) {
    if ($pipeprocess->status()->name() eq 'not_started') {
      $pipeprocess->job_identifier('some_job');
      $pipeprocess->time_queued(DateTime->now());
      $pipeprocess->status($queued_status);
      $pipeprocess->update();
    }
  }

  $pipeprocess_rs = $schema->resultset('Pipeprocess')->search();

  # this is a bad way to test things as these numbers change each time a new
  # process is added
  my %count_exp = (0 => 22, 1 => 66, 2 => 97, 3 => 153, 4 => 213, 5 => 263, 6 => 263);

  is($pipeprocess_rs->count(), $count_exp{$i}, "process count for iteration: $i");

  # fake what pipework.pl does to test the runables
  while (my $pipeprocess = $pipeprocess_rs->next()) {
    if ($pipeprocess->status()->name() ne 'queued') {
      next;
    }

    $pipeprocess->time_started(DateTime->now());
    $pipeprocess->status($started_status);
    $pipeprocess->update();

    my $process_type_name = $pipeprocess->process_conf()->type()->name();

    my @pipedatas = $pipeprocess->input_pipedatas();
    ok(@pipedatas >= 1);
    my $pipedata = $pipedatas[0];

    SmallRNA::PipeWork::run_process(schema => $schema, config => $config,
                                    pipeprocess => $pipeprocess);

    if ($process_type_name =~ /^remove adaptors/) {
      my $remove_adaptors_string = 'remove_adaptor_rejects';
      my $reads_string = 'trimmed_reads';

      ok(@pipedatas == 1, 'one pipedata as input to the pipeprocess');

      if ($pipedata->file_name() =~ /SL236/) {
        # no barcodes:
        my $prefix = "SL236.090227.311F6AAXX.s_1";

        my $out_file_name = $config->data_directory() . "/SL236/SL236.$reads_string.fasta";
        my $rej_file_name = $config->data_directory() . "/$remove_adaptors_string/$prefix.$remove_adaptors_string.fasta";

        ok(-e $out_file_name, 'looking for output file');
        ok(-e $rej_file_name, 'looking for reject file');
      } else {
        if ($pipedata->file_name() =~ /SL234/) {
          my $common = "090202.30W8NAAXX.s_1";

          my $b_out_file_name = $config->data_directory() . "/SL234_B/SL234_B.$reads_string.fasta";
          my $c_out_file_name = $config->data_directory() . "/SL234_C/SL234_C.$reads_string.fasta";
          my $rej_file_name = $config->data_directory() . "/$remove_adaptors_string/SL234_BCF.$common.$remove_adaptors_string.fasta";

          ok(-s $b_out_file_name, "look for $b_out_file_name");
          ok(-s $c_out_file_name, "look for $c_out_file_name");
          ok(-s $rej_file_name, "looking for reject file ($rej_file_name)");
        }
      }
    } else {
      if ($process_type_name =~ /ssaha alignment/) {
        if ($pipedata->file_name() =~ /SL236/) {
          # TODO
        }
      }
    }
  }
}
