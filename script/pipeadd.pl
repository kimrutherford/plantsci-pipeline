#!/usr/bin/perl -w

use strict;

use warnings;

use Getopt::Long;

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNA::Web;
use SmallRNA::DBLayer::Loader;

my $c = SmallRNA::Web->commandline();
my $config = $c->config();

my $schema = SmallRNA::DB->schema($config);

my $data_dir = $c->config()->data_directory();

# set defaults
my %options = (
               add_project => undef,
               add_biosample => undef,
               add_pipedata => undef,
              );

my $option_parser = new Getopt::Long::Parser;
$option_parser->configure("gnu_getopt");

my %opt_config = (
                  "add-project|p" => \$options{add_project},
                  "add-biosample|s" => \$options{add_biosample},
                  "add-data|d" => \$options{add_pipedata},
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
  $0 -p <project_description> <project_type> <owner>
(Add a project, prints the new project name)
  $0 -s <project_name> <ecotype> <organism_name> <molecule_type> [biosample_identifier]
(Add a biosample to the given project_name, if no biosample_identifier is given
create one.  The new biosample is printed to STDOUT)
  $0 -d <biosample_identifier> <file_name> <content_type> <format_type>
(Add the given file to the given biosample, by copying it to $data_dir)
USAGE
}

if (!$option_parser->getoptions(%opt_config)) {
  usage();
}

if (!($options{add_project} || $options{add_biosample} || $options{add_pipedata})) {
  usage("You must specify the type to add");
}

my $loader = SmallRNA::DBLayer::Loader->new(schema => $schema);

if ($options{add_project}) {
  if (@ARGV == 3) {
    my $project_type = $schema->find_with_type('Cvterm', 'name', $ARGV[1]);
    my $owner = $schema->find_with_type('Person', 'username', $ARGV[2]);
    my $project = $loader->create_with_prefix('Pipeproject', 'name', 'P_',
                                              { description => $ARGV[0],
                                                type => $project_type,
                                                owner => $owner
                                              });

    print $project->name(), "\n";
  } else {
    usage("--add-project needs three arguments");
  }
}

if ($options{add_biosample}) {
  if (@ARGV < 5 || @ARGV > 6) {
    usage("--add-biosample needs 3 or 4 arguments");
  } else {
    my $project = $schema->find_with_type('Pipeproject', 'name', $ARGV[0]);
    my ($genus, $species) = split / /, $ARGV[2];
    my $organism = $schema->find_with_type('Organism', { genus => $genus,
                                                         species => $species });
    my $ecotype = $schema->find_with_type('Ecotype', { description => $ARGV[1],
                                                       organism => $organism });
    my $molecule_type = $schema->find_with_type('Cvterm', 'name', $ARGV[3]);

    my $biosample = $schema->create_with_type('Biosample',
                                             { description => $ARGV[4],
                                               name => $ARGV[5],
                                               pipeproject => $project,
                                               molecule_type => $molecule_type,
                                               ecotype => $ecotype,
                                              });
    print $project->name(), "\n";
  }
}

if ($options{add_pipedata}) {
  if (@ARGV == 4) {
    my $biosample = $schema->find_with_type('Biosample', 'name', $ARGV[0]);
    my $ecotype = $schema->find_with_type('Ecotype', { description => $ARGV[1],
                                                       organism => $organism });
    my $content_type = $schema->find_with_type('Cvterm', 'name', $ARGV[2]);
    my $format_type = $schema->find_with_type('Cvterm', 'name', $ARGV[3]);

    my $pipe_data = $schema->create_with_type('Pipedata',
                                             { description => $ARGV[4],
                                               name => $ARGV[5],
                                               pipeproject => $project,
                                               molecule_type => $molecule_type,
                                               ecotype => $ecotype,
                                              });
    print $project->name(), "\n";
  } else {
    usage("--add-data needs 4 arguments");
  }
}
