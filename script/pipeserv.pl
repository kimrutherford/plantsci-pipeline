#!/usr/bin/perl -w

# This script periodically checks the status of jobs and data files in
# the database looking for new pipeprocesses to start.  Most of the
# hard work is done in the ProcessManager class.

# There are two steps:
#   1. Create new Pipeprocess objects in the database with status "not_started".
#      This is done by ProcessManager::create_new_pipeprocesses().
#   2. For each Pipeprocess in the database with a "not_started" status, queue
#      a job with Torque and mark it as "queued" in the database
# Repeat...

# Usage:
#   pipeserv.pl config_file.yaml

use strict;

use Carp;
use DateTime;
use FindBin qw($Bin);
use Cwd qw(realpath getcwd);
use Time::HiRes qw(usleep);
use Getopt::Long;
use POSIX ":sys_wait_h";
use Getopt::Std;

use SmallRNA::DB;
use SmallRNA::Config;
use SmallRNA::DBLayer::Loader;
use SmallRNA::ProcessManager;

my $RUN_DIR = 'pipeserv-run';
my $CONDOR_Q_COMMAND = 'condor_q';

# set defaults
my %options = (
               max_jobs => undef,
               use_torque => undef,
               exec_host => undef,
              );

my $option_parser = new Getopt::Long::Parser;
$option_parser->configure("gnu_getopt");

my %opt_config = (
                  "max-jobs|m=i" => \$options{max_jobs},
                  "torque|t" => \$options{use_torque},
                  "host|h=s" => \$options{exec_host},
                 );

sub usage
{
  my $message = shift;

  if (defined $message) {
    $message .= "\n";
  } else {
    $message = '';
  }

  die <<"USAGE";
${message}
usage:
  $0 [-t | -h host ] [-m <num>] config_file_name

options:
  -t run using torque
  -h run on the given host with ssh and exec
  -m maximum simultaneous jobs
USAGE
}

if (!$option_parser->getoptions(%opt_config)) {
  usage();
}

my $run_locally = defined $options{exec_host};

my $use_condor = !$run_locally && !$options{use_torque};

my $config_file_name = shift;

my $config = SmallRNA::Config->new($config_file_name);

my $config_file_full_path = realpath($config_file_name);

my $schema = SmallRNA::DB->new($config);

my $proc_manager = SmallRNA::ProcessManager->new(schema => $schema);

my $queued_status = $schema->find_with_type('Cvterm', name => 'queued');
my $started_status = $schema->find_with_type('Cvterm', name => 'started');
my $not_started_status = $schema->find_with_type('Cvterm', name => 'not_started');

my $test_mode = $ENV{SMALLRNA_PIPELINE_TEST} || 0;
my $pipework_path = "./pipework.pl";

sub submit_condor_job {
  my $pipeprocess = shift;
  my $pipeprocess_id = $pipeprocess->pipeprocess_id();

  my $process_conf_detail = $pipeprocess->process_conf()->detail();
  my $max_process_size = 1_800_000;

  if (defined $process_conf_detail) {
    if ($process_conf_detail =~ /max_process_size:\s*([^,]+)/) {
      $max_process_size = $1;
    }
  }

  my $env = "PIPEPROCESS_ID=$pipeprocess_id "
    . "CONFIG_FILE_PATH=$config_file_full_path "
    . "SMALLRNA_PIPELINE_TEST=$test_mode "
    . "MAX_PROCESS_SIZE=$max_process_size";


  my $command = "$env condor_submit -v submit_file";

  warn "starting: $command\n";

  open my $condor_subhandle, '-|', $command
    or die "couldn't open pipe from qsub: $!\n";

  my $saved_output = '';

  my $condor_jobid;

  while (defined (my $line = <$condor_subhandle>)) {
    if ($line =~ /\*\*\s*Proc\s*(\d+\.\d+)/) {
      $condor_jobid = $1;
    }

    $saved_output .= $line;
  }

  if (defined $condor_jobid) {
    warn "started job with pipeprocess_id: $pipeprocess_id and job id: $condor_jobid\n";
  } else {
    warn "failed to read the job id from condor_submit command, output was:

$saved_output

The job will be retried later\n";

    sleep 5;
  }

  close $condor_subhandle or warn "couldn't close pipe from condor_submit: $!\n";

  return $condor_jobid;
}

sub submit_torque_job {
  my $pipeprocess = shift;
  my $pipeprocess_id = $pipeprocess->pipeprocess_id();

  my $process_conf_detail = $pipeprocess->process_conf()->detail();
  my $torque_flags = '';

  if (defined $process_conf_detail) {
    if ($process_conf_detail =~ /torque_flags:\s*([^,]+)/) {
      $torque_flags = $1;
    }
  }

  my %environment_vars = (PIPEPROCESS_ID => $pipeprocess_id,
                          SMALLRNA_PIPELINE_TEST => $test_mode,
                          CONFIG_FILE_PATH => $config_file_full_path);
  my $environment_vars =
    join ',', map { "$_=" . $environment_vars{$_} } keys %environment_vars;

  my $command =
    "qsub $torque_flags -v $environment_vars $pipework_path";

  open my $qsub_handle, '-|', $command
    or die "couldn't open pipe from qsub: $!\n";

  my $qsub_jobid = <$qsub_handle>;

  chomp $qsub_jobid;

  if (!defined $qsub_handle) {
    die "failed to read the job id from qsub command: $!\n";
  }

  chomp $qsub_handle;

  # finish reading everything from the pipe so that qsub doesn't get a SIGPIPE
  1 while (<$qsub_handle>);

  warn "started job with pipeprocess_id: $pipeprocess_id and job id: $qsub_jobid\n";

  close $qsub_handle or die "couldn't close pipe from qsub: $!\n";

  return $qsub_jobid;
}

my $child_count = 0;

sub _get_exec_host
{
  if ($options{exec_host} =~ /^(.*?),(.*)/) {
    # hack to rotate the exec hosts:
    $options{exec_host} = "$2,$1";
    return $1;
  } else {
    return $options{exec_host};
  }
}

sub submit_local_job {
  my $pipeprocess = shift;
  my $pipeprocess_id = $pipeprocess->pipeprocess_id();

  my $pid = fork();

  if (defined $pid) {
    if ($pid) {
      # parent
      warn "started job for pipeprocess #$pipeprocess_id, job #$pid\n";
      # sleep to allow the child to exec()
    } else {
      # wait for parent to finish writing to the pipeprocess table
      sleep(1);
      $ENV{PIPEPROCESS_ID} = $pipeprocess_id;
      $ENV{CONFIG_FILE_PATH} = $config_file_full_path;
      $ENV{SMALLRNA_PIPELINE_TEST} = $test_mode;

      my $cwd = getcwd();

      $cwd =~ s:/export/:/:;

      my $command = "PIPEPROCESS_ID=$pipeprocess_id CONFIG_FILE_PATH=$config_file_full_path SMALLRNA_PIPELINE_TEST=$test_mode $cwd/$pipework_path";

      if ($options{exec_host} && $options{exec_host} ne 'localhost') {
        my $real_exec_host = _get_exec_host();
        my $ssh_command = qq(ssh $real_exec_host $command);
        warn "execuiting $ssh_command\n";
        exec "$ssh_command 2>&1 | tee out.$$.err";
      } else {
        exec $command;
      }
    }
  } else {
    croak "fork() failed\n";
  }

  $child_count++;

  return $pid;
}


# Find and remove jobs that we sent to the job runner (eg. Condor)
# that have disappeared from Condor, but aren't marked as "finished"
# or "failed".  That can happen if a job is killed or a machine fails.
sub remove_missing_jobs {
  my %current_job_ids = ();

  if ($use_condor) {
    open PIPE, "$CONDOR_Q_COMMAND|" or die "can't open pipe to $CONDOR_Q_COMMAND: $?\n";

    while (defined (my $line = <PIPE>)) {
      if ($line =~ /^\s*(\d+.\d+)\s/) {
        $current_job_ids{$1} = 1;
      }
    }

    close PIPE or die "can't close pipe to $CONDOR_Q_COMMAND: $?\n";
  }

  my $pipeprocess_rs =
    $schema->resultset('Pipeprocess')->
      search({ -or => [
        status => $started_status->cvterm_id(),
        status => $queued_status->cvterm_id()
       ]});

  my $code = sub {
    my @jobs_to_remove = ();

    while (my $pipeprocess = $pipeprocess_rs->next()) {
      my $pipeprocess_id = $pipeprocess->pipeprocess_id();

      my $job_identifier = $pipeprocess->job_identifier();

      if (!exists $current_job_ids{$job_identifier}) {
        warn "WARNING: job missing: $job_identifier for $pipeprocess_id\n";
        push @jobs_to_remove, $pipeprocess;
      }
    };

    for my $pipeprocess (@jobs_to_remove) {
      $schema->resultset('PipeprocessInPipedata')->search({
        pipeprocess_id => $pipeprocess->pipeprocess_id(),
      })->delete();
      $pipeprocess->delete();

    }
  };

  $schema->txn_do($code);
}


my @local_jobs = ();

while (1) {
  my $failed_count = $proc_manager->remove_failed_pipeprocesses();

  warn "deleted $failed_count failed jobs\n";

  remove_missing_jobs($schema);

  warn "creating new Pipeprocess objects\n";

  my @pipeprocesses = $proc_manager->create_new_pipeprocesses();

  warn "created ", scalar(@pipeprocesses), " pipeprocess entries\n";

  my $pipeprocess_rs =
    $schema->resultset('Pipeprocess')->search({ status => $not_started_status->cvterm_id() });

  while (my $pipeprocess = $pipeprocess_rs->next()) {
    my $code = sub {
      my $pipeprocess_id = $pipeprocess->pipeprocess_id();

      my $prev_status = $pipeprocess->status();

      $pipeprocess->time_queued(DateTime->now());
      $pipeprocess->status($queued_status);

      my $job_id;
      if ($run_locally) {
        $job_id = submit_local_job($pipeprocess);

        push @local_jobs, $job_id;
      } else {
        if ($use_condor) {
          $job_id = submit_condor_job($pipeprocess);
        } else {
          $job_id = submit_torque_job($pipeprocess);
        }
      }

      if (defined $job_id) {
        $pipeprocess->job_identifier($job_id);
        $pipeprocess->update();
      } else {
        $pipeprocess->status($prev_status);
        $pipeprocess->time_queued(undef);
      }
    };

    $schema->txn_do($code);

    if (defined $options{max_jobs} && $options{max_jobs} > 0) {
      for (1..1000) { # don't do it forever, in case there's a problem
        # sleep if there are too many jobs running
        if ($child_count >= $options{max_jobs}) {
          warn "$child_count jobs running - sleeping\n";
          if ($test_mode) {
            sleep (1);
          } else {
            sleep (20);
          }
          if ($run_locally) {
            my $kid;
            do {
              $kid = waitpid(-1, WNOHANG);
              if ($kid > 0) {
                $child_count--;
              }
            } while $kid > 0;
          }
        } else {
          last;
        }
      }
    }
  }

  if ($test_mode || $run_locally) {
    sleep (5);
  } else {
    sleep (180);
  }
}
