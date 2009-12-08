# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'SmallRNA-Pipeline';
all_from 'lib/SmallRNA/DB.pm';

requires 'Chart::Clicker';
requires 'DBIx::Class::ResultSet::Data::Pageset';
requires 'Params::Validate';
requires 'YAML';
requires 'DBIx::Class';
requires 'Text::CSV';
requires 'IO::All';
requires 'DBIx::Class';
requires 'DBIx::Class::Schema';
requires 'DBD::Pg';
requires 'DateTime';
requires 'Params::Validate';
requires 'File::Copy::Recursive';
requires 'Data::Compare';
requires 'Pod::Usage';

requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
catalyst;

install_script 'script/pipework.pl';
install_script 'script/pipeserv.pl';
install_script 'script/pipeinit.pl';

auto_install;
WriteAll;
