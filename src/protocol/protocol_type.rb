module Pockethernet
  module Protocol
    module Type
      HEADER_SIZE = 0x04
      ACK         = [0xBA, 0xBE].freeze
      NACK        = [0xCA, 0xFE].freeze

      FD             =  0x00
      GET_DEV_INFO   = [0x01].freeze
      GET_LI         = [0x03].freeze
      STATIC_IP      = [0x10].freeze
      PING_REQ       = [0x11].freeze
      PORT_BLINK     = [0x20].freeze
      TONING         = [0x22].freeze
      GET_WM         = [0x30].freeze
      GET_VOLTS      = [0x31].freeze
      GET_TDR        = [0x32].freeze
      PHY_CONFIG     = [0x33].freeze
      GET_LINK       = [0x34].freeze
      PACKET_CAPTURE = [0x35].freeze
      HTTP_REQ       = [0x36].freeze
      ENABLE_DHCP    = [0x38].freeze
      SET_VLAN       = [0x39].freeze
      BER_REQ        = [0x40].freeze
      GET_TDR_PLOT   = [0x41].freeze
      PORT_BLINK_V2  = [0x42].freeze
      DEV_INFO       = [0x10, 0x01].freeze
      LI             = [0x10, 0x03].freeze
      PING_RES       = [0x10, 0x11].freeze
      WM             = [0x10, 0x30].freeze
      VOLTS          = [0x10, 0x31].freeze
      TDR            = [0x10, 0x32].freeze
      PCAPTURE       = [0x10, 0x35].freeze
      HTTP_RES       = [0x10, 0x36].freeze
      BER_RES2       = [0x10, 0x40].freeze
      TDR_PLOT       = [0x10, 0x41].freeze
      CDP_LLDP       = [0x11, 0x00].freeze
      DHCP           = [0x11, 0x01].freeze
      TRAFFIC        = [0x11, 0x02].freeze
      MAX_LENGTH     = [0x07, 0xD0].freeze # 2000

      PHY_CONF_UP          = [0x00, 0x01].freeze
      PHY_CONF_ISOLATE     = [0x00, 0x02].freeze
      PHY_CONF_MDI         = [0x00, 0x04].freeze
      PHY_CONF_MDIX        = [0x00, 0x08].freeze
      PHY_CONF_DTE_DETECT  = [0x00, 0x10].freeze
      PHY_CONF_AN_ADV      = [0x00, 0x20].freeze
      PHY_CONF_SPEED_10    = [0x00, 0x40].freeze
      PHY_CONF_SPEED_100   = [0x00, 0x80].freeze
      PHY_CONF_SPEED_1000  = [0x01, 0x00].freeze
      PHY_CONF_HALF_DUPLEX = [0x02, 0x00].freeze
      PHY_CONF_FULL_DUPLEX = [0x04, 0x00].freeze
      PHY_CONF_LINK_SELF   = [0x08, 0x00].freeze
      PHY_CONF_DOWNSHIFT   = [0x10, 0x00].freeze

      TDR_FAULT_OPEN       = [0x00].freeze
      TDR_FAULT_BAD_TERM   = [0x01].freeze
      TDR_FAULT_GOOD_TERM  = [0x02].freeze
      TDR_FAULT_SHORT_SELF = [0x04].freeze
      TDR_FAULT_SHORT_0    = [0x05].freeze
      TDR_FAULT_SHORT_1    = [0x06].freeze
      TDR_FAULT_SHORT_2    = [0x07].freeze
      TDR_FAULT_SHORT_3    = [0x08].freeze
    end
  end
end
