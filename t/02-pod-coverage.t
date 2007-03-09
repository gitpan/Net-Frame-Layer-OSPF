eval "use Test::Pod::Coverage tests => 4";
if ($@) {
   use Test;
   plan(tests => 1);
   skip("Test::Pod::Coverage required for testing");
}
else {
   pod_coverage_ok("Net::Frame::Layer::OSPF");
   pod_coverage_ok("Net::Frame::Layer::OSPF::Hello");
   pod_coverage_ok("Net::Frame::Layer::OSPF::Lsa");
   pod_coverage_ok("Net::Frame::Layer::OSPF::LinkStateUpdate");
}
