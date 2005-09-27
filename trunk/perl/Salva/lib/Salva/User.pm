package Salva::User;
use Carp;
use base qw (Class::Accessor);
Salva::User->mk_accessors(qw(firstname lastname1 lastname2 sex
			     dateofbirth birthcountry_id birthcity 
			     birthstate maritstat_id migratorystatus_id
			     photo other));

sub new {
    my ($class, $dbh, $id, $debug ) = @_;
    
    
    unless ( ref $dbh and $id   ) {
	carp 'Usage: ', $class, '->new($dbh, $id, $debug)';
	return undef;
    }

    my $self = {};
    $self->{id} = $id;
    $self->{dbh} = $dbh;
    $self->{debug} = $debug;

    return bless $self, $class;
}

sub get {
    my $self = shift;
    return $self->_get(@_);
}

sub set {
    my $self = shift;
    return $self->_set(@_);
}

sub add {
    my $self = shift;
    my $params = shift;

    return undef if ( $self->_ck_uid($self->{id}) );

    $params->{uid} = $self->{id};
    
    return $self->{dbh}->sql_insert('personal', $params, 0);
}

sub update {
    my $self = shift;
    my $params = shift;

    unless ( $self->_ck_uid($self->{id}) ) {
	return undef;
    }

    $params->{uid} = $self->{id};

    return $self->{dbh}->sql_update('personal', $params, 'uid');
}

####################################################################
# Private methods 
sub _get { 
    my ($self, $field) = @_;
    return undef unless  $field;
    my $table = 'personal';
    return $self->{dbh}->get_field($table,$field,'uid',$self->{id});
}

sub _set { 
    my ($self, $field, $value) = @_;
    return undef unless ($field and $value);
    my $table = 'personal';

    return $self->{dbh}->set_field($table,$field, $value,'uid', $self->{id});
}

sub _ck_uid {
    my $self = shift; 
    return $self->_get('uid');
}

1;
