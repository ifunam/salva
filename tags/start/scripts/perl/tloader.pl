#!/usr/bin/perl -w

# $scripts: tloader.pl,v 1.1 2004/11/25  18:49:53 alex Exp $
#
# Copyright (c) 2004 Alejandro Juarez <alex@fisica.unam.mx>
#            Victor Fragoso  <vmanuel@fisica.unam.mx>                         
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFT
#                                                                             
# PURPOSE: This script was created to extract data from a file and after that 
#          insert these data to a table using some database(Pg,mysql,etc)     
#                                                                             
# USAGE: To read the use instructions you need to run perldoc using this      
#         script perldoc tloader.pl                                           


use strict;
use DBI;
use Getopt::Long;
use Data::FormValidator;

main();

sub main {

    #Here we are setting the default values to open a database conection using
    #the predefined user and database for postgresql.
    my $defaults = {
        dbname   => 'template1',
        user     => '_postgresql',
        passwd   => 'somefuckingpassphrase',
        verbose  => 0,
        splitter => ',',
	driver   => 'Pg'
    };
    
    #Receiving parameters.
    my ( %options, $value );
    $value = GetOptions(
        \%options,    "dbname=s",  "user=s",  "passwd=s",
        "port=i",     "host=s",    "table=s", "fields=s",
        "splitter=s", "verbose",   "file=s",  "driver=s"
    );
  
    #Checking that everything have gone Ok
    if ( $value != 0 ) {
	#Checking whether the required parameters where given.
        my @required = qw( dbname user file table fields splitter );
        my @optional = qw( passwd host port verbose );
        my $dfv      = {
            required => \@required,
            optional => \@optional,
            msgs     => {
                prefix                 => '',
                missing_optional_valid => 0
		},
	   };
        my $results = Data::FormValidator->check( \%options, \%$dfv );
        if ( $results->has_missing or $results->has_invalid ) {
            print "The next options are missing or are invalid: \n";
            map { print "$_\n" } keys %{ $results->msgs };
        } else {
	    foreach my $key ( keys %options ) {
		if ( exists $options{$key} && defined $options{$key} ) {
		    $defaults->{$key} = $options{$key};
		}
	    }
            loaddb($defaults);
        }
    }  else {
        print "The next options are missing or are invalid: \n";
        map { print "$_\n" } keys %$defaults;
    }
}

sub loaddb { 
    my $params = shift;

    # Here we build the sentence with the parameters given.
    my $dbparams = "dbi:$params->{driver}:dbname='$params->{dbname}'";
    if ( $params->{host} ) {
        $dbparams .= ";host='$params->{host}'";
        if ( $params->{port} ) {
            $dbparams .= ";port='$params->{port}';";
        }
    }

    my $dbh = DBI->connect( $dbparams, $params->{passwd} ? 
			    ( $params->{user}, $params->{passwd} ) :
			    $params->{user} )
      or die "I can't open the database $params->{dbname}" . DBI->errstr;

    #We open the file with the info.
    if ( -f $params->{file} ) {
        open( my $fh, '<', "$params->{file}" );
        my @file = <$fh>;
        close($fh);

        # Building the SQL query.
        my $fields = $params->{fields};
        my $values = join( ',', map { '?' } split( /,/, $params->{fields} ) );
        my $sql = "INSERT INTO $params->{table} ($fields) VALUES ($values)\n";
        print "SQL: $sql\n" if $params->{verbose};
        my $sth = $dbh->prepare($sql);

	#Exctracting and processing the info.
        for my $line (@file) {
            if ( $line !~ /^\#|^$|^\s.*$/ ) {
                $line =~ s/\n//g;
                my @values = split( /$params->{splitter}/, $line );
                $sth->execute(@values);
                print join( ':', @values ) . "\n" if $params->{verbose};

		#If there was an error.

                if ( DBI->errstr ) {
                    print  DBI->errstr;
                    print "[SQL: $sql]\n";
                    print join( ',', map { "[$_]" } @values ) . "\n";
                }
            }
        }

        $sth->finish;
        $dbh->disconnect;
        print "$0 has inserted data to the table $params->{table} from the "
	    . "file $params->{file} \n";
        exit 0;
    }#If file passed wasn't found.
    else {
        warn "The file $params->{file} not found \n";
        exit 1;
    }
}


=head1 NAME

    Tloader - A perl script to insert data into a table.

=head1 SYNOPSIS

    tloader.pl [ -dbname [database] ] [ -fields [field1,field2,...] ]
               [ -h [host] ] [ -u [username] ] [ -passwd [password] ]
               [ -t [table] ] [ -file [file] ] [ -s [splitter] ]
               [ -port [port] ] [ -driver [drivername] ] [ -v ]

=head1 DESCRIPTION

    Tloader is a perl script using DBI and DBD that inserts data, 
    taken from a file, into a table in the database. 
    
    Tloader options:

    -dbname   Specify the database name. (Required)
    
    -fields   Receieve the fields that'll  be used to build the SQL 
              query.(Required)

    -h        Specify the host from your connecting with the database.
              (Optional)

    -u        The database user. (Required)

    -password The database user's password.(Optional)

    -t        The table that'll receieve the data.(Required)

    -file     The file that contains the information, that'll be 
              introduced. (Required)

    -s        The splitter is the character that separates yout file 
              information. It is a simple caracter like ',', ':' etc.
              (Required)     
         
    -port     The port you'll use to connect the database.
              (Optional)

    -driver   Specify the driver to use. By default Postgresql is set.
              (Optional)

    -v        Enables verbose mode.


=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by Alejandro Juarez and Victor Fragoso

This script is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.3 or,
at your option, any later version of Perl 5 you may have available.

=cut
   
