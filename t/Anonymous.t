use Test::More tests => 1;
BEGIN { use_ok('Net::Scan::Ftp::Anonymous') };

my $host = "127.0.0.1";

my $scan = Net::Scan::Ftp::Anonymous->new({
	host    => $host,
	timeout => 5,
	verbose => 0,
	debug   => 1
});

my $results = $scan->scan;

if ($results){
	print "$host $results\n";
}

exit(0);
