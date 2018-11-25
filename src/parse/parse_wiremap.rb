module Pockethernet
  module Parse
    class Wiremap
      attr_accessor :payload, :wires, :shorts

      def initialize(payload)
        @payload = payload
        @wires   = Array.new(9)
        @shorts  = Array.new(9)
        deserialize
      end

      # Unpackage the payload into two arrays for wire mapping and shorts
      # Work Flow:
      #   Iterate 4 times using positional math to insert data into the arrays
      #   Take the upper and lower 4 bits of each byte of the payload
      #     and convert them into their numeric wire value
      def deserialize
        4.times do |pair|
          @wires[pair * 2] = @payload[pair] & 0x0F
          @wires[pair * 2 + 1] = ((@payload[pair] & 0xF0) >> 0x04)
          @shorts[pair * 2] = @payload[pair + 4] & 0x0F
          @shorts[pair * 2 + 1] = ((@payload[pair + 4] & 0xF0) >> 0x04)
        end

        @wires[8]  = @payload[8] & 0x0F
        @shorts[8] = 0
      end

      # Return a boolean based on if there are any shorts in the cable
      def shorted?
        @shorts.any? { |wire| wire > 0 }
      end

      # Return the cable type based on the decoded wires
      # If no cable type is returned the value is defaulted to miswire
      def cable_type
        Pockethernet::Parse::Type::WIREMAP_TYPE.fetch(@wires) { 'Miswire' }
      end

      # Returns the cable color order based on the decoded wires
      def cable_order
        @wires.map { |wire| Pockethernet::Parse::Type::WIREMAP_568A[wire] }
      end
    end
  end
end
