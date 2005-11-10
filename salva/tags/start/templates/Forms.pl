use strict;
use Template;
use Date::Format;
use CGI qw(:form :html2);
use Config::IniFiles;
use DBI::SQL::Abstract;

my $file  = '/home/alex/lib/salva.conf';
my $cfg   = Config::IniFiles->new( -file => $file );
my $dbcfg = $cfg->SectionsParams( [ 'DBA', 'DBI' ] );
my $dbh   = DBI::SQL::Abstract->new(%$dbcfg);

sub _execquery {
    my %args = @_;
    my $sql  = $args{-sql};
    my $db   = $args{-db};
    my $sth  = $db->prepare($sql);
    $sth->execute;
    if ( $sth->rows > 0 ) {
        my %values;
        while ( my ( $key, $value ) = $sth->fetchrow_array ) {
            $values{$key} = $value;
        }
        return \%values;
    }
    else {
        return undef;
    }
    $sth->finish;
}

sub _filetoref {
    my %args     = @_;
    my $filename = $args{-file};
    open my $fh, '<', $filename or warn "Can't open the file: $filename";
    my @array = <$fh>;
    close($fh);
    my $ref = {};
    foreach my $line (@array) {
        my ( $key, $value ) = split( /:/, $line );
        $ref->{$key} = $value;
    }
    return $ref;
}

# Setting the params for the functions of CGI.pm and return It in a
# hash reference
sub _setparams {
    my %args = @_;
    my $ref  = $args{ -ref };
    my $db   = $args{-db};
    my $js   = $args{-js};
    my $css  = $args{-css} || 'text';

    # Setting the CGI form function name, please check the CGI perl module
    # documentation, perldoc CGI
    my $cgifunc = $ref->{cgifunc};

    # Setting the initial params for the CGI Function
    my %params = (
        -name     => $ref->{field},
        -class    => $css,
        -tabindex => $ref->{tabindex}
    );

    # If the Javascript support is enabled we'll set the constraint
    # funtion in the parameter for this field
    if ( $js == 1 ) {
        $params{-onchange} = "javacscript:$ref->{constfunc}\()";
    }

    # If we'll need use the follow kind of functions, then we'll store in
    # a hash reference($dictquery) the results from a query into a plain
    # text file or from a table in a database.
    my $dictquery;
    if (   $cgifunc eq 'popup_menu'
        || $cgifunc eq 'scrolling_list'
        || $cgifunc eq 'checkbox_group'
        || $cgifunc eq 'radio_group' )
    {
        if ( $ref->{sql} =~ /^_/ ) {
            $ref->{sql} =~ s/^_//;
            $dictquery = &_filetoref( -file => $ref->{sql} );
        }
        else {
            $dictquery = &_execquery( -sql => $ref->{sql}, -db => $db );
        }
    }

    # Well, here we'll check the cgi function type and set their parameters,
    # if you can't understand the options used in the hash %params, please
    # check the CGI module documentation: perldoc CGI
    if ( $cgifunc eq 'textfield' || $cgifunc eq 'password_field' ) {

        $params{-size}      = $ref->{colslength};
        $params{-maxlength} = $ref->{rowsmaxlength};

    }
    elsif ( $cgifunc eq 'filefield' ) {

        $params{-size}  = $ref->{colslength};
        $params{-width} = $ref->{rowsmaxlength};

    }
    elsif ( $cgifunc eq 'textarea' ) {

        $params{-rows}    = $ref->{rowslength};
        $params{-columns} = $ref->{colsmaxlength};
        $params{-wrap}    = 'soft';

    }
    elsif ( $cgifunc eq 'popup_menu' ) {

        $params{ -values } = [ sort { $a <=> $b } keys %{$dictquery} ];
        $params{-labels} = \%{$dictquery};

    }
    elsif ( $cgifunc eq 'scrolling_list' ) {

        $params{ -values } = [ sort { $a <=> $b } keys %{$dictquery} ];
        $params{-labels}   = \%{$dictquery};
        $params{-size}     = $ref->{colslength};
        $params{-multiple} = $ref->{rowsmaxlength};

    }
    elsif ( $cgifunc eq 'checkbox_group' || $cgifunc eq 'radio_group' ) {

        $params{ -values } = [ sort { $a <=> $b } keys %{$dictquery} ];
        $params{-labels}  = \%{$dictquery};
        $params{-rows}    = $ref->{rowsmaxlength};
        $params{-columns} = $ref->{colslength};

    }
    elsif ( $cgifunc eq 'submit' ) {

        $params{-value} = $cgifunc;
        $params{-class} = 'submit';

    }
    elsif ( $cgifunc eq 'hidden' ) {
        $params{-default} = $cgifunc;
    }
    else {
        warn "The $cgifunc function not exist ";
    }

    return %params;
}

sub fieldform {
    my ( $db, $ref, $repeat, $js ) = @_;

    # Extracting the CGI function to execute
    my $cgifunc = $ref->{cgifunc};

    # Making the params for the CGI Function
    my %params = &_setparams( -ref => $ref, -db => $db, -js => $js );

    # Returning the result of the execution of the CGI function, it
    # means something like: textfield(\%params) or popup_menu(\%params)
    no strict "refs";
    return &{$cgifunc}( \%params );
}

sub fieldsformdb {
    my ( $db, $form, $js, $help, $repeat ) = @_;
    my $sth = $db->prepare(<<'SQL');
    SELECT TRIM(form) as form, TRIM(field) as field, 
    TRIM(validation) as validation, TRIM(constfunc) as constfunc,
    TRIM(cgifunc) as cgifunc, colslength, rowsmaxlength,
    TRIM(sql) as sql, hid, tabindex
    FROM dictionary  
    WHERE form = ?
    ORDER BY tabindex ASC
SQL
    $sth->execute($form);    # Extracting the fields related to each form
    my @fields;
    while ( my $ref = $sth->fetchrow_hashref ) {
        push @fields,
          {
            label => $ref->{field},
            field => &fieldform( $db, $ref, $repeat, $js ),
            js    => $js,
            hid   => $ref->{hid},
            type  => $ref->{validation}
          };
    }
    $sth->finish;

    return \@fields;
}

# set STDOUT to auto-flush and print header
$file = 'form.tmpl';
my $tdir = '/home/alex/lib/templates';
my $lang = "$tdir/lang";

my $template = Template->new(
    {
        INCLUDE_PATH => "$tdir:$lang",
        PRE_PROCESS  => 'es',
    }
);

my $js   = undef;
my $user = 'alex';
my $data = {

    # Params for the template
    time   => time2str( '%d/%m/%Y %T', time ),
    year   => time2str( '%Y',          time ),
    user   => $user,
    meta   => 'personal',              # Setting from your the language file,
    submit => 'insert',
    form   => {
        enctype => 'application/x-www-form-urlencoded',
        method  => 'post',
        action  => '/Salva/Personal/Update/',
    },
    js     => $js,
    fields => fieldsformdb( $dbh, 'personal', $js )

};

$template->process( $file, $data )
  || die $template->error(), "\n";
