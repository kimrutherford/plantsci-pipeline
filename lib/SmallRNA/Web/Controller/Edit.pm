package SmallRNA::Web::Controller::Edit;

=head1 NAME

SmallRNA::Web::Controller::Edit - controller to handler /edit/... requests

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Web::Controller::Edit

You can also look for information at:

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

=cut

use strict;
use Carp;

use base 'Catalyst::Controller::HTML::FormFu';

use SmallRNA::DBLayer::Path;

sub _get_field_values
{
  my $c = shift;
  my $table_name = shift;
  my $class_name = shift;
  my $select_values = shift;
  my $field_info = shift;

  my $field_name = $c->config()->{class_info}->{$table_name}->{display_field};

  my $values_constraint = $field_info->{values_constraint};

  my $constraint_path = undef;
  my $constraint_value = undef;

  # constrain the possible values shown in the list by using the
  # values_constraint from the config file
  if (defined $values_constraint) {
    my $pattern = qr|^\s*(.*?)\s*=\s*"(.*)"\s*$|;
    if ($values_constraint =~ /$pattern/) {
      $constraint_path = SmallRNA::DBLayer::Path->new(path_string => $1);
      $constraint_value = $2;
    } else {
      die "values_constraint '$values_constraint' doesn't match pattern: $pattern\n";
    }
  }

  my $rs = $c->schema()->resultset($class_name);

  my @res = ();

  my $table_id_column = $table_name . '_id';

  while (defined (my $row = $rs->next())) {
    if (defined $values_constraint) {
      my $this_constrain_value = $constraint_path->resolve($row);
      next unless $constraint_value eq $this_constrain_value;
    }

    my $option = { value => $row->$table_id_column(),
                   label => $row->$field_name() };

    if (grep { $row->$table_id_column() eq $_ } @$select_values) {
      $option->{attributes} = { selected => 't' };
    }

    push @res, $option;
  }

  return @res;
}

# the names of buttons in the form so we can skip them later
my @INPUT_BUTTON_NAMES = qw(submit cancel);

sub _init_form_field
{
  my $c = shift;
  my $field_info = shift;
  my $object = shift;

  my $type = $object->table();

  my $field_label = $field_info->{field_label};

  my $display_field_label = $field_label;
  $display_field_label =~ s/_/ /g;

  next unless $field_info->{editable};

  my $field_db_column = $field_label;

  if (defined $field_info->{field_conf}) {
    $field_db_column = $field_info->{field_conf};
  }

  my $elem = {
    name => $field_db_column, label => $display_field_label
  };

  my $class_name = SmallRNA::DB::class_name_of_table($type);
  my $db_source = $c->schema()->source($class_name);

  my $info_ref;

  if (!$field_info->{is_collection}) {
    $info_ref = $class_name->relationship_info($field_db_column);
  }

  if (defined $info_ref) {
    my %info = %{$info_ref};
    my $referenced_class_name = $info{class};

    my $referenced_table = SmallRNA::DB::table_name_of_class($referenced_class_name);

    if (!defined $field_label) {
      die "no display_key_fields configuration for $referenced_table\n";
    }

    $elem->{type} = 'Select';
    my $table_id_column = $referenced_table . '_id';

    my $current_value = undef;
    if (defined $object && defined $object->$field_db_column()) {
      $current_value = $object->$field_db_column()->$table_id_column();
    } else {
      $current_value = $c->req->param("$referenced_table.id");
    }

    $elem->{options} = [_get_field_values($c, $referenced_table,
                                          $referenced_class_name,
                                          [$current_value], $field_info)];

    my $field_is_nullable = $db_source->column_info($field_db_column)->{is_nullable};

    if ($field_is_nullable) {
      # add a blank to the select list if this field can be null
      unshift @{$elem->{options}}, [0, ''];
    }
  } else {
    if ($field_info->{is_collection}) {
      my $referenced_class_name = $field_info->{referenced_class};

      my $referenced_table = SmallRNA::DB::table_name_of_class($referenced_class_name);

      $elem->{type} = 'Checkboxgroup';
      my $table_id_column = $referenced_table . '_id';

      # my $current_value = undef;
      # if (defined $object && defined $object->$field_db_column()) {
      #   $current_value = $object->$field_db_column()->$table_id_column();
      # } else {
      #   $current_value = $c->req->param("$referenced_table.id");
      # }

      $elem->{options} = [_get_field_values($c, $referenced_table,
                                            $referenced_class_name,
                                            [], $field_info)];
    } else {
      $elem->{type} = 'Text';
      if (!$db_source->column_info($field_db_column)->{is_nullable}) {
        $elem->{constraints} = [ { type => 'Length',  min => 1 },
          'Required' ];
      }
      if (defined $object) {
        $elem->{value} = $object->$field_db_column();
      } else {
        # try to set the default value (if configured)
        my $default_value_code = $field_info->{default_value};

        if (defined $default_value_code) {
          $elem->{value} = eval "$default_value_code";
          if ($@) {
            warn "error evaluating default_value configuration for "
              . "'$field_label': $@";
          }
        }
      }
    }
  }

  return $elem;
}

# Initialise the form using the list of field_infos in the config file.
# Attributes will be rendered as text areas, references as pop ups.
sub _initialise_form
{
  my $c = shift;
  my $object = shift;
  my $form = shift;

  my @elements = ();

  my $type = $object->table();

  my $class_info_ref = $c->config()->{class_info}->{$type};
  if (!defined $class_info_ref) {
    croak "can't find configuration for editing $type objects\n";
  }

  my $field_infos_ref = $class_info_ref->{field_info_list};
  if (!defined $field_infos_ref) {
    croak "can't find any field_info configuration for editing $type objects\n";
  }

  my @field_infos = @{$c->config()->{class_info}->{$type}->{field_info_list}};

  for my $field_info (@field_infos) {
    push @elements, _init_form_field($c, $field_info, $object);
  }

  $form->default_args({elements => { Text => { size => 50 } } });

  $form->auto_fieldset(1);
  $form->elements([
                    @elements,
                    map { {
                      name => $_, type => 'Submit', value => ucfirst $_
                    } } @INPUT_BUTTON_NAMES,
                  ]);

}

sub _create_object {
  my $schema = shift;
  my $table_name = shift;
  my $form = shift;

  my $class_name = SmallRNA::DB::class_name_of_table($table_name);

  my %form_params = %{$form->params()};
  my %object_params = ();

  for my $name (keys %form_params) {
    if (grep { $_ eq $name } @INPUT_BUTTON_NAMES) {
      next;
    }

    my $value = $form_params{$name};

    my $info_ref = $class_name->relationship_info($name);

    if (defined $info_ref && $value == 0) {
      # special case for undefined references which are represented in the form
      # as a 0
      $value = undef;
    }

    if ($value =~ /^\s*$/) {
      # if the user doesn't enter anything, use undef
      $value = undef;
    }

    $object_params{$name} = $value;
  }

  return $schema->create_with_type($class_name, { %object_params });
}

sub _update_object {
  my $object = shift;
  my $form = shift;

  my %form_params = %{$form->params()};

  for my $name (keys %form_params) {
    if (grep { $_ eq $name } @INPUT_BUTTON_NAMES) {
      next;
    }

    my $value = $form_params{$name};

    my $info_ref = $object->relationship_info($name);

    if (defined $info_ref && $value == 0) {
      # special case for undefined references which are represented in the form
      # as a 0
      $value = undef;
    }

    $object->$name($value);
  }

  $object->update();
}

sub object : Regex('(new|edit)/object/([^/]+)(?:/([^/]+))?') {
  my ($self, $c) = @_;

  my ($req_type, $type, $object_id) = @{$c->req->captures()};

  my $object = undef;

  if (defined $object_id) {
    my $class_name = SmallRNA::DB::class_name_of_table($type);
    $object = $c->schema()->find_with_type($class_name, "${type}_id" => $object_id);
  }

  my $st = $c->stash;

  my $display_type_name = SmallRNA::DB::display_name($type);

  if ($req_type eq 'new') {
    $st->{title} = "New $display_type_name";
  } else {
    $st->{title} = "Edit $display_type_name";
  }

  $st->{template} = "edit.mhtml";

  my $form = $self->form;

  _initialise_form($c, $object, $form);

  $form->process;

  $c->stash->{form} = $form;

  if ($form->submitted() && defined $c->req->param('cancel')) {
    if ($req_type eq 'new') {
      $c->res->redirect($c->uri_for("/"));
      $c->detach();
    } else {
      $c->res->redirect($c->uri_for("/view/object/$type/$object_id"));
      $c->detach();
    }
    die;
  }

  if ($form->submitted_and_valid()) {
    if ($req_type eq 'new') {
      $c->schema()->txn_do(sub {
                             my $object = _create_object($c->schema(), $type, $form);
                             my $table_id_column = $type . '_id';
                             # get the id so we can redirect below
                             $object_id = $object->$table_id_column();
                           });
    } else {
      $c->schema()->txn_do(sub {
                             _update_object($object, $form);
                           });
    }

    $c->res->redirect($c->uri_for("/view/object/$type/$object_id"));
    $c->detach();
  }
}

1;
