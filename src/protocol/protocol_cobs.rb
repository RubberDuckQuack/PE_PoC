module Pockethernet
  module Protocol
    module COBS
      # Decode a COBS encoded byte array
      def self.decode(in_bytes)
        out_bytes = []
        idx       = 0

        unless in_bytes.empty?
          loop do
            length = in_bytes[idx].ord
            raise 'Zero byte found in input' if length.zero?

            idx += 1
            ending = idx + length - 1
            copy_bytes = in_bytes[idx...ending]

            raise 'Zero byte found in input' if copy_bytes.include? 0

            out_bytes += copy_bytes
            idx = ending

            raise 'Not enough input bytes for length code' if idx > in_bytes.length

            if idx < in_bytes.length
              out_bytes.push 0 if length < 255
            else
              break
            end
          end
        end

        out_bytes
      end

      # Encode a byte array into COBS encoding
      def self.encode(in_bytes)
        final_zero       = true
        out_bytes        = []
        idx              = 0
        search_start_idx = 0

        in_bytes.each do |in_char|
          if in_char.zero?
            final_zero = true
            out_bytes.push (idx - search_start_idx + 1)
            out_bytes += in_bytes[search_start_idx...idx]
            search_start_idx = idx + 1
          elsif (idx - search_start_idx) == 0xFD
              final_zero = false
              out_bytes += 255
              out_bytes += in_bytes[search_start_idx...idx + 1]
              search_start_idx = idx + 1
          end
          idx += 1
        end

        if (idx != search_start_idx) || final_zero
          out_bytes.push (idx - search_start_idx + 1)
          out_bytes += in_bytes[search_start_idx...idx]
        end

        out_bytes
      end
    end
  end
end
