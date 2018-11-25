module Pockethernet
  module Engine
    module Transport
      # Connect to a rfcomm device via a socket with custom sockaddr structure
      # Work Flow:
      #   Create the socket with (31 = AF_BLUETOOTH, 1 = SOCK_STREAM, 3 = BTPROTO_RCOMM)
      #   Pack the sockaddr structure with the address and channel we are connecting to
      #   Connect to the device
      @client = nil
      @address = nil
      def self.connect(address)
        @address = address
        rf_chan = 5

        @client = Socket.new 31, 1, 3
        sockaddr = [31, 0, *@address.split(':').reverse_each.map(&:hex), rf_chan, 0].pack('C*')
        @client.connect sockaddr
      end

      # Read from the rfcomm device discarding the first file deliminator
      # until the second file deliminator is met
      # Work Flow:
      #   Check if the rfcomm device exists
      #   Open the rfcomm device for reading
      #   Read the first byte, discarding it if it is the file deliminator
      #   Read indefinitetly until another file deliminator is met
      #   Return the packet buffer
      def self.read_packet
        raise 'Not connected to the Pockethernet!' if @client.nil?

        buffer = []
        byte = @client.read(1)
        buffer.push byte.ord unless byte.ord == Pockethernet::Protocol::Type::FD

        loop do
          byte = @client.read(1)
          break if byte.ord == Pockethernet::Protocol::Type::FD

          buffer.push byte.ord
        end

        buffer
      end

      # Send a crafted packet to the rfcomm device
      # Work Flow:
      #   Check if the rfcomm device exists
      #   Serialize the packet and write it to the rfcomm device
      def self.send_packet(packet)
        raise 'Not connected to the Pockethernet!' if @client.nil?

        @client.write packet.serialize
      end

      # Receive a complete packet from the rfcomm device and return a
      # deserialized packet
      # Work Flow:
      #   Create a new packet with the result of read_packet
      #   Return a deserialized packet
      def self.receive_packet
        raw_packet = read_packet

        packet = Pockethernet::Protocol::Packet.new
        packet.deserialize(raw_packet)
        packet
      end
    end
  end
end
