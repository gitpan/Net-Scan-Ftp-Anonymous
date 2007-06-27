package Net::Scan::Ftp::Anonymous;

use 5.008006;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);
use Carp;
use IO::Socket;
use Net::FTP;

our $VERSION = '0.02';
$VERSION = eval $VERSION;

__PACKAGE__->mk_accessors( qw(host port timeout directory user password verbose debug));

$| = 1;

sub scan {

	my $self      = shift;
	my $host      = $self->host;
	my $port      = $self->port      || 21;
	my $timeout   = $self->timeout   || 8;
	my $directory = $self->directory || 'test007';
	my $user      = $self->user      || 'anonymous';
	my $password  = $self->password  || 'postmaster@127.0.0.1';
	my $verbose   = $self->verbose   || 0;
	my $debug     = $self->debug     || 0;

	my $ftp = Net::FTP->new( $host, Timeout => $timeout);

	my $results;

	if ($ftp){
		if ($ftp->login($user,$password)){
			if ($ftp->mkdir($directory)){
				if ($verbose eq 0){
					$results = "w";
				} elsif ($verbose eq 1){
					$results = "write access";
				}
				$ftp->rmdir($directory);
			} else {
				if ($verbose eq 0){
					$results = "r";
				} elsif ($verbose eq 1){
					$results = "read access";
				}
			}
		}

       		$ftp->quit;
	} else {
		$results = "ftp connection refused" if $debug;
	}

	return $results;
}

1;
__END__

=head1 NAME

Net::Scan::Ftp::Anonymous - scan for anonymous read/write access FTP servers

=head1 SYNOPSIS

  use Net::Scan::Ftp::Anonymous;

  my $host = $ARGV[0];

  my $scan = Net::Scan::Ftp::Anonymous->new({
    host    => $host,
    timeout => 5,
    verbose => 1,
    debug   => 0 
  });

  my $results = $scan->scan;

  print "$host $results\n" if $results;

=head1 DESCRIPTION

This module permit to scan for anonymous read/write access FTP servers.

=head1 METHODS

=head2 new

The constructor. Given a host returns a L<Net::Scan::Ftp::Anonymous> object:

  my $scan = Net::Scan::Ftp::Anonymous->new({
    host      => "127.0.0.1",
    port      => 21,
    timeout   => 5,
    directory => 'test007',
    user      => 'anonymous',
    password  => 'postmaster@127.0.0.1',
    verbose   => 1,
    debug     => 0 
  });

Optionally, you can also specify :

=over 2

=item B<port>

Remote port. Default is 21 tcp;

=item B<timeout>

Default is 8 seconds;

=item B<directory>

Directory created to verify write access. It will be delete after check. Default is "test007";

=item B<user>

Default is 'anonymous'; 

=item B<password>

Defaults is 'postmaster@127.0.0.1';

=item B<verbose>

Set to 1 enable verbose; 0 display "r" or "w", 1 display "read access" or "write access" as output;

=item B<debug>

Set to 1 enable debug. Debug displays "connection refused" when an FTP server is unrecheable. Default is 0;

=back

=head2 scan 

Scan the target.

  $scan->scan;

=head1 SEE ALSO

RFC 959 

=head1 AUTHOR

Matteo Cantoni, E<lt>mcantoni@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

You may distribute this module under the terms of the Artistic license.
See Copying file in the source distribution archive.

Copyright (c) 2006, Matteo Cantoni

=cut
