# $Id$
package Salva::DB;
use strict;
use Carp;
use DBIx::SQL::Abstract;
our @ISA = qw(DBIx::SQL::Abstract);
our $VERSION = '0.01';

sub new {
    my $class = shift;
    my %params = @_;

    my @knownargs = qw (debug dbname user passwd attr);
    _ck_args(\@knownargs, \%params, [qw(dbname user)]);
    
    $params{attr} = {AutoCommit => 1} unless $params{attr};
    
    my $dbh = DBIx::SQL::Abstract->new(dbname => $params{dbname}, 
				       user => $params{user}, 
				       passwd => $params{passwd}, 
				       attr => $params{attr});
    
    $dbh->{private_debug} = $params{debug} || 0;
    
    return bless $dbh, $class;
}

######################################################################
# Database functions                                                 #
######################################################################
sub get_field {
    my ($self, $table, $field, $key, $keyval) = @_;

    my $dbh = $self; 
    my $debug = $dbh->{private_debug};     
    
    unless ( $#_ == 4 ) {
	croak 'You need specify: dbh, table, field, key, keyval';
    }    
    
    my $sql = "SELECT $field FROM $table WHERE $key = ?";
    print "SQL: $sql \n", "VALUES: $keyval \n" if ( $debug == 1);
    
    my $sth = $dbh->prepare($sql) or 
	carp "Can\'t prepare [$sql]: ", $dbh->errstr;
    
    $sth->execute($keyval) or 
	carp "Can\'t execute SQL: $sql, using the value: $keyval \n",
	$dbh->errstr;
    
    return $sth->fetchrow_array;
    
    $sth->finish;
}

sub set_field { 
    my ($self, $table, $field, $fieldval, $key, $keyval) = @_;

    my $dbh = $self; 
    my $debug = $dbh->{private_debug};         
    unless ( $#_ == 5 ) {
	croak 'You need specify: dbh, table, field, fieldval, key, keyval';
    }    

    my @values = ($fieldval, $keyval);
    my $sql = "UPDATE $table SET $field = ? WHERE $key = ?";
    
    print "SQL: $sql\n", "VALUES: ", join (', ', @values), "\n"	
	if ( $debug == 1);
    
    my $sth;
    unless ( $sth = $dbh->prepare($sql) and  $sth->execute(@values) ) {
	carp "Can\'t execute SQL: $sql, using the value(s): ", 
	join (', ', @values), "\n", $dbh->errstr;
	return undef;
    } else {
	$sth->finish;
	return 1;
    }
}

sub sql_insert {
    my ($self, $table, $params, $noseq) = @_;

    my $dbh = $self; 
    my $debug = $dbh->{private_debug}; 

    unless ( $#_ == 2 ||  $#_  == 3 ) {
	carp 'Usage: $dbh->sql_insert($table, \%params, 0|1)';
	return undef;
    }

    unless ( ref($params) eq 'HASH' ) {
	carp "The 2nd argument should be a hash reference: \%params";
	return undef;
    }

    $noseq = 1 if not defined $noseq;    


    my ($sql, @values) = $dbh->insert($table, \%$params);    
    
    my $sql_ok = $self->_sql_execute($sql, \@values, $debug);
    
    # We'll return the value of the new serial, if the 
    # previus query was executed successfully and the argument
    # 'noseq' is not equal to one.

    if ( $sql_ok && $noseq != 0 ) {
	$sql = "SELECT currval(\'$table\_id_seq\')";
	my $sth =  $dbh->prepare($sql);
	unless ( $sth->execute ) {
	    carp "Could not query for the new ID: ", $dbh->errstr;
	    $dbh->rollback unless $dbh->{AutoCommit} == 1;
	}
	my ($id) = $sth->fetchrow_array;
	$sth->finish;
	return $id;
    }
    
}

sub sql_update {
    my ($self, $table, $params, $key) = @_;

    unless ( $#_ == 2 ) {
	carp 'Usage: $dbh->sql_update($table, \%params, $key)';
	return undef;
    }
    
    unless ( ref($params) eq 'HASH' ) {
	carp "The 2nd argument should be a hash reference: \%params";
	return undef;
    }

    my $dbh = $self;
    my $debug = $dbh->{private_debug}; 
    
    die "The key should be defined in the params too" 
	unless ( $params->{$key} );
    my $keyval = $params->{$key};
    
    # We set the %where hash, it will be used in some SQL::Abstract way
    # to create a SQL WHERE CLAUSULE using the following *mode*:
    # WHERE ( key = ? ) 
    my %where = ( $params->{$key} => { '=', $keyval } );
    delete $params->{$key};
    
    # We build the UPDATE query and assigning their values    
    my($sql, @values) = $dbh->update($table, \%$params, \%where);
    
    # Executing the Query    
    _sql_execute($dbh, $sql, \@values, $debug);
    
    return 1;
}

sub sql_delete {
    my  %args = @_;
    
    my @knownargs = qw(dbh tbl params);
    _ck_args(\@knownargs, \%args, \@knownargs);
    
    
    # We get the name of the table and the private_debug mode for this object
    my $dbh = $args{dbh}; 
    my $table = $args{tbl};

    my $debug = $dbh->{private_debug}; 
    
    # We set the %where hash, it will be used in some SQL::Abstract way
    # to create a SQL WHERE CLAUSULE using the following *mode*:
    # WHERE ( key1 = ? ) AND ( keyN = ? ) ... AND (...)
    my %where;
    my $params = $args{params}; 
    for my $key ( keys %$params ) {
	$where{$key} = { '=', $params->{$key} };
    }
    
    # We build the DELETE query and assigning their values
    my($sql, @values) = $dbh->delete($table, \%where);
    
    # Executing the Query
    _sql_execute($dbh, $sql, \@values, $debug) ;

    return 1;
}

sub is_known_field {
    # Returns the table name where the field exists if it is valid, 
    # undef otherwise
    my ($dbh, $field, $known);
    $dbh = shift;
    $field = shift;
    $known = shift;
    my $knownfields = join('|', @$known);

    unless ( $field =~ /^($knownfields)$/ ) {
	carp "Unknown field requested: $field - Valid fields are:\n", 
	$knownfields;
	return undef;
    }

    return 1;
}

#########################################################################
# Private methods                                                       #
#########################################################################
sub _sql_execute {
    my ($dbh, $sql, $values, $debug) = @_;
    
    my $sth = $dbh->prepare($sql) or 
	carp "Can\'t prepare [$sql]: ", $dbh->errstr;
    
    print "SQL: $sql \n", "VALUES: ", join(', ', @$values), "\n" 
	if ( $debug == 1);
    
    if ( $sth->execute(@$values) ) {
	$dbh->commit unless $dbh->{AutoCommit} == 1;
	return 1;
	
    } else {
	$dbh->rollback unless $dbh->{AutoCommit} == 1;
 	carp "Can\'t execute SQL: $sql, using the value(s): ",
	join (', ', @$values), "\n", $dbh->errstr;
	return undef;
    }
    
    $sth->finish;
}


sub _ck_args {
    my $args = shift;
    my $argsto_ck = shift;
    my $reqargsto_ck = shift; # Required arguments 
    
    my $knownargs; # Known argunments
    # Checking the type of the data of each argument
    unless ( $#_ != 1 ||  $#_ != 2) {
	croak 'Use 3 args: \@known_args, \%argstocheck, \@requiredargs';
    }
    
    if ( ref($args) eq 'HASH') {
	croak 'Can\'t use a hash in the 1st argument';
	
    } elsif ( ref($args) eq 'ARRAY') {
 	$knownargs = join ('|', @$args); 
	
    } else {
	$knownargs = $args;
    }
    
    croak 'Use a hash in the 2nd argument' if (ref($argsto_ck) ne 'HASH');
    
    # Checking if here we had unknown arguments
    my @badargs = grep { $_ !~ /^($knownargs)$/ } keys %$argsto_ck;
    
    if ( @badargs ) {
	carp 'Unknown argument(s) received: ', join(', ', @badargs), "\n",
	"The known arguments are: [$knownargs]";
    } 
    
    my @reqargs; # Checking for the required arguments
    if ( defined $reqargsto_ck ) {
	
	if ( ref($reqargsto_ck) eq 'HASH') {
	    croak 'Can\'t use a hash in the 3rd argument';
	    
	} elsif ( ref($reqargsto_ck) eq 'ARRAY') {
	    @reqargs = @$reqargsto_ck;
	    
	} else {
	    @reqargs = $reqargsto_ck;
	}

	# Checking for the existence of explicit arguments
	my @missing = grep { ! $argsto_ck->{$_} } @reqargs;
	if ( @missing ) {
	    croak "You need specify the following specific options: ",
	    join(', ',@reqargs), "\n", 
	    "Missing values in the following options: ", join (', ', @missing);
	}
	
    }

    return 1;
}

1;

__END__
