module Pockethernet
  module Protocol
    module CRC
      # Create a CRC16 checksum of the entire supplied packet using
      # a CCITT algrorithm with a FFFF start location
      def self.crc16(packet)
        crc = 0xFFFF

        packet.each do |byte|
          crc =  ((crc >> 8) | (crc << 8)) & 0xFFFF
          crc ^= (byte & 0xFF)
          crc ^= ((crc & 0xFF) >> 4)
          crc ^= (crc << 12) & 0xFFFF
          crc ^= ((crc & 0xFF) << 5) & 0xFFFF
        end

        crc &= 0xFFFF

        [(crc & 0x00FF), ((crc & 0xFF00) >> 8)]
      end
    end
  end
end
