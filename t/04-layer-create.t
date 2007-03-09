use Test;
BEGIN { plan(tests => 1) }

use Net::Frame::Layer::OSPF qw(:consts);
use Net::Frame::Layer::OSPF::Hello;
use Net::Frame::Layer::OSPF::LinkStateUpdate;
use Net::Frame::Layer::OSPF::Lsa;

my $l = Net::Frame::Layer::OSPF->new;
$l->pack;
$l->unpack;

$l = Net::Frame::Layer::OSPF::Hello->new;
$l->pack;
$l->unpack;

$l = Net::Frame::Layer::OSPF::LinkStateUpdate->new;
$l->pack;
$l->unpack;

$l = Net::Frame::Layer::OSPF::Lsa->new;
$l->pack;
$l->unpack;

ok(1);
