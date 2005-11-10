#!/usr/bin/perl -w
use File::Glob ':glob';
use IO::File;

my ($out, %tables, %files, $totals);

for my $file (bsd_glob('*.sql')) {
    $files{$file} = [0, 0];

    my $data = IO::File->new($file, 'r') or die $!;
    while (my $line = $data->getline) {
	next unless $line =~ /^\s*CREATE TABLE (\w+)/;
	my $table = $1;

	# Log tables are deprecated - We still count them, just not to lose
	# information over the old index, but we will kill them mercilessly
	# soon.
	if ($table =~ /_logs$/) { 
	    $files{$file}[1]++;
	} else {
	    $files{$file}[0]++;
	}

	warn "Warning: $table redefined ($tables{$table}, $file)"
	    if defined $tables{$table};

	$tables{$table} = $file;
    }
}

$out = IO::File->new('tables.index', 'w') 
    or die $!;

$out->print("SALVA tables directory\n======================\n\n");

for my $table (sort keys %tables) {
    $out->print(sprintf("%-32s %s\n", $table, $tables{$table}));
}

$out->print('-'x70,"\n\n");
$out->print("Tables distribution\n===================\n\n",
	    sprintf("%-30s  %-20s\n", 'File', 'Tables'));

for my $file (sort keys %files) {
    $out->print(sprintf("%-30s  %-20s\n", 
			$file, $files{$file}[0], $files{$file}[1]));
    $totals += $files{$file}[0];
}

$out->print(sprintf("\n%-30s  %-20s\n", 'Total tables:',$totals));
