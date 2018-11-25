module Pockethernet
  module Protocol
    class Packet
      attr_accessor :type, :length, :packet_payload, :crc
      def initialize
        @type    = [0x00]
        @length  = [0x00]
        @crc     = [0x00, 0x00]
        @packet_payload = []
      end

      # Write a series of bytes to the packet buffer
      # Used for creating outgoing packets
      def write_bytes(bytes)
        bytes.each { |byte| @packet_payload.push byte }
      end

      # Read a series of bytes from start to start+n and return a byte array
      # Used for reading data from incoming packets
      def read_bytes(start, stop)
        bytes = @packet_payload[start...start + stop]
        bytes.collect { |byte| byte }
      end

      # Get the payload of the current packet
      def payload
        read_bytes(Pockethernet::Protocol::Type::HEADER_SIZE,
                   @packet_payload.length - Pockethernet::Protocol::Type::HEADER_SIZE)
      end

      # Package the packet into a string to be sent to the device
      # Work Flow:
      #   Insert packet type
      #   Insert packet length
      #   Insert two placeholder nullbytes for CRC16
      #   Insert the packet_payload data
      #   Calculate CRC16 checksum for
      #     [packet_type (1 byte)][packet_length (1 byte)][packet_crc (2 null bytes)[packet (n bytes)]
      #   Insert the CRC16 bytes replacing the null placeholders
      #   COBS encode the packet
      #   Add null byte pre/post amble
      def serialize
        data = []

        data.push @type.first
        # @length = [@packet_payload.length]
        data.push @length.first.to_s.to_i(16)
        data.push 0x00
        data.push 0x00

        data += @packet_payload

        @crc = Pockethernet::Protocol::CRC.crc16(data)
        data[2] = @crc[0]
        data[3] = @crc[1]

        cobs_packet = Pockethernet::Protocol::COBS.encode(data)
        cobs_packet = cobs_packet.map(&:chr).join

        "\x00#{cobs_packet}\x00"
      end

      # Unpackage the packet into a byte array for reading
      # Work Flow:
      #   COBS decode the packet into a byte array
      #   Retrieve the packet type
      #   Retrieve the packet length
      #   Retrieve the CRC16 checksum
      #   Insert null byte placeholders at CRC location
      #   Calculate CRC16 checksum for the packet
      #   Compare the packet checksum to calculated checksum
      def deserialize(packet)
        @packet_payload = Pockethernet::Protocol::COBS.decode(packet)

        @type   = read_bytes(0, 1)
        @length = read_bytes(1, 1)

        @crc = read_bytes(2, 2)
        @packet_payload[2] = 0
        @packet_payload[3] = 0
        crc = Pockethernet::Protocol::CRC.crc16(@packet_payload)

        raise 'CRC16 checksum failed' if @crc != crc
      end
    end
  end
end
