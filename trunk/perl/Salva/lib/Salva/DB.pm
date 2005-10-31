package Salva::DB;
use strict;
use Carp;
use DBI;

###
### MISSING HERE: Check that the specified table is valid in get_fields.
###               Probably, a get_tables should be here as well... 
###

=head1 NAME

Salva::DB - Handles the database connectivity for Salva

=head1 SYNOPSIS

    $db = Salva::DB->new(dbname => 'salva',
                         dbuser => 'salva',
                         dbpasswd => 'p4ssw0rd',
                         host => undef,
                         port => 5432);

All the attributes for the object creation are optional; C<-dbname>, 
C<-dbuser>, C<-host> and C<-port> are shown with their default values. Password
will default to undef unless supplied. 

You might get scared on why C<-host> is set to undef - It is so because 
localhost means making a TCP/IP connection to 127.0.0.1, while undef means
using a local connection - and this is handled differently in PostgreSQL's
configuration.

Salva::DB provides the following DBI methods:

    $sth = $db->prepare($sql);
    $ok = $db->begin_work;
    $ok = $db->commit;
    $ok = $db->rollback;

For all other DBI methods, they can be accessed through
C<$db-E<gt>{dbh}-E<gt>methodname>, althought their use is discouraged.

    %fields = $db->get_fields($tablename);

Returns the list of fields in the specified table, their data type, if they
accept null values and -if they have it- their description, in the following 
format:

    ( name => { type => 'text', required => 1, description => "User's name" },
      age => { type => 'integer', required => 0 },
      (...) );

This is: C<type> is the data type, C<required> is a boolean showing whether it
is required or not, and C<description> is the field's description.

=head1 SEE ALSO

L<Salva::DB::Catalog>

=cut
#################################################################
# Object constructor and destructor

sub new {
    # The constructor for Salva::DB
    my ($self, $class, %par, %allowed);
    $class = shift;
    if (@_ % 2) {
	carp 'Invocation error - Wrong number of parameters';
	return undef;
    }
    %par = @_;

    # Initialize $self with default values
    $self = {-dbname => 'salva',
	     -dbuser => 'salva',
	     -host => undef,
	     -port => undef,
	     -lastMsg => ''};

    # Handle user-supplied parameters, checking no illegal parameters
    # were received
    %allowed = (-dbname => 1, -dbuser => 1, -host => 1, -port => 1,
		-dbpasswd => 1);

    for my $key (keys %par) {
	if (!defined $allowed{$key}) {
	    carp "Invalid parameter received ($key)";
	    return undef;
	}
	$self->{$key} = $par{$key};
    }

    # Open database connection
    my %dbparam = (AutoCommit => 1, PrintError => 1, RaiseError => 0,
		   ShowErrorStatement => 1);

    # Functional magic: Of those defined from dbname, host, port
    # place them in a string separated by ;
    my $dsn = join ';' ,
      map { "$_=$self->{-$_}" }
        grep { defined $self->{-$_} }
          qw(dbname host port);

    $self->{-dbh} = DBI->connect("dbi:Pg:$dsn",
				 $self->{-dbuser},
				 $self->{-dbpasswd},
				 \%dbparam) or
	carp("Failed to open database connection:\n",$DBI::errstr) &&
	return undef;

    # Ok, the object is created - Bless it and return
    bless $self, $class;
    return $self;
}

sub DESTROY {
    # In this destructor we explicitly disconnect from the database in order
    # to prevent warnings/inconsistencies from the system.
    my $self = shift;
    if (ref $self->{-dbh}) {
	# Rollback any pending transactions, if any, before disconnecting.
        $self->{-dbh}->{AutoCommit} or $self->{-dbh}->rollback;

	$self->{-dbh}->disconnect;
    }
}

#################################################################
# Envelopes for functions passed to DBI

sub prepare {
    my ($self, $ret);
    $self = shift;
    return $self->{-dbh}->prepare(@_);
}

sub begin_work {
    my ($self, $ret);
    $self = shift;
    return $self->{-dbh}->begin_work(@_);
}

sub commit {
    my ($self, $ret);
    $self = shift;
    return  $self->{-dbh}->commit(@_);
}

sub rollback {
    my ($self, $ret);
    $self = shift;
    return $self->{-dbh}->rollback(@_);
}

######################################################################
# Other regular methods

sub get_fields {
    my ($self, $table, $sth);
    $self = shift;
    $table = shift;

    unless ($sth = $self->prepare('SELECT attrname, type, required, description
            FROM table_attributes WHERE relname = ?') and
	    $sth->execute($table)) {
	carp "Could not query for $table's fields";
	return undef;
    }

    return %{$sth->fetchall_hashref('attrname')}
}

1;
