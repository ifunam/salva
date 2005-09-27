package Salva::User;
use strict;
use Carp;

sub new {
    my ( $class, $dbh, $id, $debug ) = @_;
    
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

sub firstname { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('firstname', $value);
    } else {
	return $self->_get('firstname');
    }
}

sub lastname1 { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('lastname1', $value);
    } else {
	return $self->_get('lastname1');
    }
}

sub lastname2 { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('lastname2', $value);
    } else {
	return $self->_get('lastname2');
    }
}

sub sex { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('sex', $value);
    } else {
	return $self->_get('sex');
    }
}

sub dateofbirth { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('dateofbirth', $value);
    } else {
	return $self->_get('dateofbirth');
    }
}

sub birthcountry_id { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('birthcountry_id', $value);
    } else {
	return $self->_get('birthcountry_id');
    }
}

sub birthcity { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('birthcity', $value);
    } else {
	return $self->_get('birthcity');
    }
}

sub birthstate { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('birthstate', $value);
    } else {
	return $self->_get('birthstate');
    }
}

sub maritstat_id { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('maritstat_id', $value);
    } else {
	return $self->_get('maritstat_id');
    }
}

sub migratorystatus_id { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('migratorystatus_id', $value);
    } else {
	return $self->_get('migratorystatus_id');
    }
}

sub photo { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('photo', $value);
    } else {
	return $self->_get('photo');
    }
}

sub other { 
    my $self = shift; 
    my $value = shift; 

    if ($value) {
	return $self->_set('other', $value);
    } else {
	return $self->_get('other');
    }
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
    return $self->{dbh}->set_field($table,$field,$value,'uid', $self->{id});
}

sub _ck_uid {
    my $self = shift; 
    return $self->_get('uid');
}
1;

__END__
