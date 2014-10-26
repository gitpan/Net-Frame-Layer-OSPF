#
# $Id: Lls.pm,v 1.2 2007/03/13 18:19:39 gomor Exp $
#
package Net::Frame::Layer::OSPF::Lls;
use strict;
use warnings;

use Net::Frame::Layer qw(:consts :subs);
our @ISA = qw(Net::Frame::Layer);

our @AS = qw(
   checksum
   dataLength
   rawTlv
);
our @AA = qw(
   tlvList
);
__PACKAGE__->cgBuildIndices;
__PACKAGE__->cgBuildAccessorsScalar(\@AS);
__PACKAGE__->cgBuildAccessorsScalar(\@AA);

use Net::Frame::Layer::OSPF qw(:consts);

sub new {
   shift->SUPER::new(
      checksum   => 0,
      dataLength => 0,
      tlvList    => [],
      @_,
   );
}

sub getLength {
   #my $self = shift;
   #my $len = 4;
   #if ($self->rawTlv) {
      #$len += length($self->rawTlv);
   #}
   #print "TLV LEN: $len\n";
   #$len;
   0;
}

sub pack {
   my $self = shift;

   my $raw = $self->SUPER::pack('nn', $self->checksum, $self->dataLength)
      or return undef;

   if ($self->rawTlv) {
      $raw .= $self->SUPER::pack('a*', $self->rawTlv)
         or return undef;
   }

   $self->raw($raw);
}

sub unpack {
   my $self = shift;

   my ($checksum, $dataLength, $payload) =
      $self->SUPER::unpack('nn a*', $self->raw)
         or return undef;

   $self->checksum($checksum);
   $self->dataLength($dataLength);

   # XXX: handle TLV
   $self->rawTlv($payload);

   #$self->payload($payload);

   $self;
}

sub print {
   my $self = shift;

   my $l = $self->layer;
   sprintf
      "$l: checksum:0x%04x  dataLength:%d\n".
      "$l: rawTlv:%s",
         $self->checksum,
         $self->dataLength,
         CORE::unpack('H*', $self->rawTlv),
   ;
}

1;

__END__

=head1 NAME

Net::Frame::Layer::OSPF::Lls - OSPF Lls type object

=head1 SYNOPSIS

   use Net::Frame::Layer::OSPF::Lls;

   my $layer = Net::Frame::Layer::OSPF::Lls->new(
      identifier     => getRandom16bitsInt(),
      sequenceNumber => getRandom16bitsInt(),
      payload        => '',
   );
   $layer->pack;

   print 'RAW: '.$layer->dump."\n";

   # Read a raw layer
   my $layer = Net::Frame::Layer::OSPF::Lls->new(raw => $raw);

   print $layer->print."\n";
   print 'PAYLOAD: '.unpack('H*', $layer->payload)."\n"
      if $layer->payload;

=head1 DESCRIPTION

This modules implements the encoding and decoding of the OSPF Lls object.

See also B<Net::Frame::Layer> for other attributes and methods.

=head1 ATTRIBUTES

=over 4

=item B<identifier>

Identification number.

=item B<sequenceNumber>

Sequence number.

=back

The following are inherited attributes. See B<Net::Frame::Layer> for more information.

=over 4

=item B<raw>

=item B<payload>

=item B<nextLayer>

=back

=head1 METHODS

=over 4

=item B<new>

=item B<new> (hash)

Object constructor. You can pass attributes that will overwrite default ones. See B<SYNOPSIS> for default values.

=back

The following are inherited methods. Some of them may be overriden in this layer, and some others may not be meaningful in this layer. See B<Net::Frame::Layer> for more information.

=over 4

=item B<layer>

=item B<computeLengths>

=item B<computeChecksums>

=item B<pack>

=item B<unpack>

=item B<encapsulate>

=item B<getLength>

=item B<getPayloadLength>

=item B<print>

=item B<dump>

=back

=head1 CONSTANTS

No constants here.

=head1 SEE ALSO

L<Net::Frame::Layer::OSPF>, L<Net::Frame::Layer>

=head1 AUTHOR

Patrice E<lt>GomoRE<gt> Auffret

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2006-2007, Patrice E<lt>GomoRE<gt> Auffret

You may distribute this module under the terms of the Artistic license.
See LICENSE.Artistic file in the source distribution archive.

=cut
