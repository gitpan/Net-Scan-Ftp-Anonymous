use 5.008006;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'Net::Scan::Ftp::Anonymous',
    VERSION_FROM      => 'lib/Net/Scan/Ftp/Anonymous.pm',
    PREREQ_PM         => {
				Class::Accessor::Fast => 0.22,
			},

    ($] >= 5.005 ?
      (ABSTRACT       => 'A simple way to scan for anonymous read/write access FTP servers.',
       AUTHOR         => 'Matteo Cantoni <mcantoni@cpan.org>') : ()),
);
