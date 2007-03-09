#
# $Id: Makefile.PL,v 1.1 2007/01/19 17:59:13 gomor Exp $
#
use ExtUtils::MakeMaker;

require v5.6.1;

WriteMakefile(
   NAME          => 'Net::Frame::Layer::OSPF',
   VERSION_FROM  => 'lib/Net/Frame/Layer/OSPF.pm',
   LICENSE       => 'Artistic',
   ABSTRACT_FROM => 'lib/Net/Frame/Layer/OSPF.pm',
   AUTHOR        => 'GomoR <perl@gomor.org>',
   PREREQ_PM     => {
      Net::Frame => 0,
   },
);
