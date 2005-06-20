package Apache::Complaints;
use Date::Format;
use Template;
use Config::IniFiles;
use DBI::SQL::Abstract;

use lib qw(/home/alex/Template-Forms/lib);
use constant CONF => '/foo/stoned/Apache-Complaints/data/complaints.conf';


my $cfg = Config::IniFiles->new( -file => CONF );
my $dbcfg = $cfg->SectionsParams(['DBA','DBI']);
my $dbh = DBI::SQL::Abstract->new(%$dbcfg);
my $sql = $dbh->select('groups', '*');
print "$sql";
#my $sth = $dbh->prepare($sql);
#$sth->execute();
#while ( my @array = $sth->fetchrow_array ) {
#    print join (', ', map { $_ } @array) . "\n";
