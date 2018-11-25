module Pockethernet
  module Engine
    module Do
      # Create and send a wiremap packet then wait for the response
      # Returning a hash with all wiremap information
      # Work Flow:
      #   Create a new packet
      #   Set packet type
      #   Send the packet to the device
      #   Receive the packet from the device
      #   Parse the packet as a wiremap packet
      #   Return wiremap information
      def self.wiremap
        wiremap_packet = Pockethernet::Protocol::Packet.new
        wiremap_packet.type = Pockethernet::Protocol::Type::GET_WM
        wiremap_packet.length = [0x00]
        Pockethernet::Engine::Transport.send_packet(wiremap_packet)

        wiremap_response_packet = Pockethernet::Engine::Transport.receive_packet
        wiremap_parser          = Pockethernet::Parse::Wiremap.new(wiremap_response_packet.payload)

        { shorted: wiremap_parser.shorted?,
          cable_type: wiremap_parser.cable_type,
          cable_order: wiremap_parser.cable_order }
      end

      # Create and send a phy config packet
      # Need to research what the byte values are, and why the length is set to zero
      # Zero length is possible a bug from the creators
      # Packet response should also be compared to the ACK/NACK packet types... eventually
      # Work Flow:
      #   Create a new packet
      #   Set packet type
      #   Write payload
      #   Send packet
      #   Receive packet response
      def self.phyconf
        phyconf_packet = Pockethernet::Protocol::Packet.new
        phyconf_packet.type = Pockethernet::Protocol::Type::PHY_CONFIG
        phyconf_packet.write_bytes [0x02, 0x00, 0x00, 0x00]
        phyconf_packet.length = [0x00]

        Pockethernet::Engine::Transport.send_packet(phyconf_packet)

        Pockethernet::Engine::Transport.receive_packet
      end
    end
  end
end
