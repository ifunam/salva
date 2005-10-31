package Salva::DB::Catalog;
use strict;
use Carp;
our $AUTOLOAD;

###
### MISSING HERE: The AUTOLOAD logic, validations for using the correct fields 
###               in _get_field, _set_field.
###

=head1 NAME

Salva::DB::Catalog - Manages Salva generic catalogs

=head1 SYNOPSIS

This module provides for easy access to generic catalogs. A generic catalog is 
very loosely defined, and basically almost any table can be treated as such 
(although they will have their own infrastructure, please use it) - Generic 
catalogs are simple, small tables, usually with only C<id> and C<name> fields 
(although might have more, but this is the usual pattern), and that don't refer
any other table.

    $cat = Salva::DB::Catalog->new($db, $catalog)

This creates a Catalog object, which will work on the catalog specified by
C<$catalog>. 

=head2 Querying for catalogs

    @catalogs = Salva::DB::Catalog->get_cataloglist($db);
    @catalogs = $cat->get_cataloglist

Will retreive the list of available generic catalogs. Of course, the system 
does not know what a generic catalog means (the list of catalogs is not 
hard-coded), so it will basically hand back the list of tables that do not
refer to any other table. C<get_cataloglist> works both as a class method and
as an instance method.

    %referers = Salva::DB::Catalog->get_referers($db, $cat_name)
    %referers = $cat->get_referers($cat_name)

Gets the list of referers (the list of other tables that refer to this
catalog). The keys for the hash are the names of the referring table, and its
corresponding value is the name of the field that makes the reference - i.e.,
for the C<country> catalog, each of the keys of the hash will be a different
table: C<personal>, C<usercitizen>, C<institutions>, C<acadvisits> and some 
others. The values for each of those keys is the column that refers from that 
table to C<country> - C<birthcountry_id> for C<personal>, C<citizen_id> for
C<citizen>, and C<country_id> for all the others. C<get_referers> worsk both
as a class method and as an instance method.

=head2 Working on a specific catalog

    $field = $cat->get_field($id);
    $field = $cat->set_field($id, $value);

This generic accessor/mutator will be used for most queries: I<field> can be
any string matching one of the catalog's fields (i.e., if our C<userstatus> 
catalog has C<id> and C<name> fields, we would use 
C<$userstatus-E<gt>get_name($id)> or C<$userstatus-E<gt>set_name($id,$name)>.

    %field = $cat->get_field_list;

This will return an id->value mapping of the catalog's IDs to the specified
field - i.e., C<$userstatus-E<gt>get_name_list> will give us back a hash with
all of the existing I<userstatus> entries, being the ID the key and the name
the value.

    %cat = $cat->get_all;

This will return all the information from the catalog, with this structure:

  (1 => {name => 'The name for ID 1', 
         created_on => '2005-10-31',
         updated_on => '2005-11-10'},
   2 => {name => 'The name for ID 2', 
         created_on => '2005-11-01',
         updated_on => '2005-11-10'},
   (...) )

with each entry being one record in the table, the key being the ID, and
all of the fields being represented in the hashref.

    $ok = $cat->delete($id)

Deletes the record with the given ID. Note that it will only be deleted if
no records on other tables reference it.

    $ok = $cat->force_delete($id)

Deletes the record with the given IDs, forcing the deletion of any records of
other tables that still reference it. Note that it can still fail - If the 
record pointing at this one is being also referenced, it will not be erased 
(that means, it will not purge referrers recursively, it only goes up one 
level).

    $id = $cat->add(field1=>$val1, $field2=>$val2)

Adds a new record in the catalog with the requested values. If any of the 
specified fields does not exist, the operation will fail. If any of the 
existing fields is not specified, an insertion with a NULL value will be 
attempted - The database might not accept a value (i.e., adding NULLs to a
not-null field, adding a duplicate value to a field with a UNIQUE constraint,
etc.). If the record can be created, its ID will be returned. If it cannot
be created, it will return undef.

=cut

#################################################################
# Object constructor and destructor

sub new {
    my ($class, $self);
    $class = shift;

    $self = bless {db => shift, cat => shift}, $class;

    unless (ref $self->{db} and defined $self->{cat} and 
	    grep {$_ eq $self->{cat}}
	    Salva::DB::Catalog->get_cataloglist($self->{db})) {
	carp "Required attributes missing or wrong";
    }

    return $self;
}

# We use autoload, so we explicitly declare an empty destructor to avoid 
# warnings
sub DESTROY {}
######################################################################
# Class methods

sub get_cataloglist {
    my ($class, $db, $sth, %res);
    $class = shift;
    $db = shift;

    # We might have been called as a function and not as a method - Try to
    # be smart!
    if (!defined $db and ref $class) {
	$db = $class;
    }

    # A catalog is defined for us as a table which refers to no other tables.
    unless ($sth = $db->prepare('SELECT tablename, description FROM tables 
            WHERE tablename NOT IN (SELECT referrer FROM related_tables)') 
	    and $sth->execute) {
	carp "Error querying the database for the catalog list";
	return undef;
    }

    return %{$sth->fetchall_hashref('tablename')}
}

sub get_referers {
    my ($class, $db, $tbl, $sth, %res);
    $class = shift;
    $db = shift;
    $tbl = shift;

    # We might have been called as a function and not as a method - Try to
    # be smart!
    if (!defined $db and ref $class) {
	$db = $class;
    }

    unless ($sth = $db->prepare('SELECT referrer, ref_key FROM related_tables
            WHERE refered = ?') and $sth->execute($tbl)) {
	carp "Error querying for the referers for table $tbl";
	return undef;
    }

    return %{$sth->fetchall_hashref('referrer')}
}

######################################################################
# Regular instance methods
sub get_all {
    my ($self, $sth);
    $self = shift;

    unless ($sth = $self->{db}->prepare("SELECT * FROM $self->{cat}") and
	    $sth->execute) {
	carp "Could not query for $self->{cat}";
	return undef;
    }

    return %{$sth->fetchall_hashref('id')};
}

sub delete {
    my ($self, $id, $sth);
    $self = shift;
    $id = shift;

    unless ($sth = $self->{db}->prepare("DELETE FROM $self->{cat} WHERE id=?")
	    and $sth->execute($id)) {
	carp "Could not delete ID $id from $self->{cat}";
	return undef;
    }
    return 1;
}

sub force_delete {
    my ($self, $id, $raiseerror);
    $self = shift;
    $id = shift;

    # Many DB operations follow - Prepare a transaction.
    $raiseerror = $self->{db}->{RaiseError};
    $self->{db}->{RaiseError} = 1;
    $self->{db}->begin_work;
    eval {
	my ($sth, %tables);

	# Which tables reference this one?
	$sth = $self->{db}->prepare('SELECT referrer, ref_key FROM 
            related_tables WHERE refered = ?');
	%tables = %{$sth->fetchall_hashref('referrer')};

	# On each of the referring tables, delete the relevant rows
	for my $table (keys %tables) {
	    $sth = $self->{db}->prepare("DELETE FROM $table WHERE 
                $tables->{$table}{ref_key} = ?");
	    $sth->execute($id);
	}

	# Finally, remove the record from this table
	$self->delete($id);

	# Success! Commit and set things back to normal
	$self->{db}->commit;
	$self->{db}->{RaiseError} = $raiseerror;
    };
    if ($@) {
	# Something went wrong - Undo any changes we did
	$self->{db}->rollback;
	$self->{db}->{RaiseError} = $raiseerror;
	carp "Could not force deletion of ID $id from $self->{cat} - " .
	    "maybe it has deep dependencies?";
	return undef;
    }

    return 1;
}

sub add {
    my ($self, %data, %fields, @ord_data, $sql, $raiseerror, $id);
    $self = shift;
    %data = @_;

    # Get the list of valid fields for this table, check no unknown fields
    # were specified. We explicitly don't want 'id' to be specified!
    %fields = $self->{db}->fields($self->{cat});
    for my $field ('id', keys %data) {
	next unless exists $fields{$field};
	carp "Unknown field $field requested - Cannot continue";
	return undef;
    }

    # We need to ensure the data stays ordered once we create our $sql
    @ord_data = map {[$_, $data{$_}]} keys %data;
    $sql = "INSERT INTO $self->{cat} ("  . 
	join(',', map {$_->[0]} @ord_data) . ') VALUES (' .
	join(', ', map {'?'} @ord_data) . ')';

    # Many DB operations follow - Prepare a transaction.
    $raiseerror = $self->{db}->{RaiseError};
    $self->{db}->{RaiseError} = 1;
    $self->{db}->begin_work;
    eval {
	# Insert the requested record
	$sth = $self->{db}->prepare($sql);
	$sth->execute(map {$_->[1]} @ord_data);

	# Get the generated ID
	$sth = $self->{db}->prepare("SELECT currval('$self->{cat}_id_seq')");
	$sth->execute;
	($id) = $sth->fetchrow_array;
    };
    if ($@) {
	# Something went wrong - Undo any changes we did
	$self->{db}->rollback;
	$self->{db}->{RaiseError} = $raiseerror;
	carp "Could not insert the requested $self->{cat}";
	return undef;
    }

    return 1;
}

######################################################################
# Specific accessors/mutators are handled via AUTOLOAD
sub AUTOLOAD {

}

######################################################################
# Private methods
sub _get_field {
    my ($self, $field, $id, $sth);
    $self = shift;
    $field = shift;
    $id = shift;

    unless ($sth = $self->{db}->prepare("SELECT $field FROM $self->{cat} WHERE
            id = ?") and $sth->execute($id)) {
	carp "Could not query for $field in $self->{cat}";
	return undef;
    }

    return $sth->fetchrow_array;
}

sub _set_field {
    my ($self, $field, $id, $val, $sth);
    $self = shift;
    $field = shift;
    $id = shift;
    $val = shift;

    unless ($sth = $self->{db}->prepare("UPDATE $self->{cat} SET $field=? WHERE
            id = ?") and $sth->execute($val, $id)) {
	carp "Could not update field $field in $self->{cat} to $val";
	return undef;
    }

    return 1;
}

1;
