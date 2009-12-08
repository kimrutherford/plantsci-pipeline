#!/usr/bin/perl -w

# Main work process called through Torque
#
# The id of the Pipeprocess for this worker to run is passed in the
# PIPEPROCESS_ID environment variable
#
# The ProcessConf for the Pipeprocess is used to decide which
# SmallRNA::RunableI to run.  The Pipeprocess is passed to the run() method
# of the SmallRNA::RunableI.

# Find the pipeprocess with ID from the environment, update start time and
# status, run the process then update finished time and status

use strict;

BEGIN {
  push @INC, '/home/kmr44/vc/pipeline/lib';
  push @INC, '/applications/pipeline/perl_lib/share/perl/5.10.0';
};

use DateTime;
use Carp;
use POSIX qw(nice);
use BSD::Resource qw(RLIMIT_VMEM setrlimit);

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNA::DBLayer::Loader;
use SmallRNA::PipeWork;

if (!exists $ENV{PIPEPROCESS_ID}) {
  die "no PIPEPROCESS_ID environment variable\n";
}

my $pipeprocess_id = $ENV{PIPEPROCESS_ID};

if (!exists $ENV{CONFIG_FILE_PATH}) {
  die "no CONFIG_FILE_PATH environment variable\n";
}

my $config_file_path = $ENV{CONFIG_FILE_PATH};

if (!-f $config_file_path) {
  $config_file_path =~ s:^/export/:/:;
}

my $config = SmallRNA::Config->new($config_file_path);
my $schema = SmallRNA::DB->schema($config);

my $started_status = $schema->find_with_type('Cvterm', name => 'started');

my $pipeprocess = $schema->resultset('Pipeprocess')->find($pipeprocess_id);

if (!defined $pipeprocess) {
  croak "error: can't find pipeprocess with id: $pipeprocess_id\n";
}

if (!$ENV{SMALLRNA_PIPELINE_TEST}) {
  # make the process nice and prevent excess memory use
  POSIX::nice(19);
  setrlimit(RLIMIT_VMEM, 32_000_000_000, 32_000_000_000);
}

my $current_status;

$schema->txn_do(sub {
                  my $time_started = $pipeprocess->time_started();
                  if (defined $time_started) {
                    warn "error: process $pipeprocess_id already started at: $time_started\n";
                  }

                  $current_status = $pipeprocess->status()->name();
                  if ($current_status eq 'queued') {
                    $pipeprocess->time_started(DateTime->now());
                    $pipeprocess->status($started_status);
                    $current_status = 'started';
                    $pipeprocess->update();
                  }
                });

if ($current_status ne 'started') {
  $schema->storage()->disconnect();
  # already started - perhaps two pipeserv.pl processes are running?
  die 'pipeprocess ', $pipeprocess_id, " already started - exiting\n";
}

my $status;
my $message;

$schema->txn_do(sub {

                  eval {
                  ($status, $message) =
                    SmallRNA::PipeWork::run_process(schema => $schema,
                                                    config => $config,
                                                    pipeprocess => $pipeprocess);

                  my $status_cvterm = $schema->find_with_type('Cvterm', name => $status);

                  if ($status eq 'finished') {
                    $pipeprocess->time_finished(DateTime->now());
                  }

                  $pipeprocess->status($status_cvterm);
                  $pipeprocess->update();
                };
                  if ($@) {
                    warn "run_process() failed for pipeprocess $pipeprocess_id: $@\n";

                    $schema->txn_rollback();
                    $schema->storage()->disconnect();
                  }
                });

if ($status eq 'failed') {
  die "$message\n";
}
