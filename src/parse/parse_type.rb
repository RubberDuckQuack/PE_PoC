module Pockethernet
  module Parse
    module Type
      WIREMAP_568A = { 0 => :disconnected,
                       1 => :light_green,
                       2 => :green,
                       3 => :light_orange,
                       4 => :blue,
                       5 => :light_blue,
                       6 => :orange,
                       7 => :light_brown,
                       8 => :brown,
                       9 => :shield }.freeze

      WIREMAP_568B = { 0 => :disconnected,
                       1 => :light_orange,
                       2 => :orange,
                       3 => :light_green,
                       4 => :blue,
                       5 => :light_blue,
                       6 => :green,
                       7 => :light_brown,
                       8 => :brown,
                       9 => :shield }.freeze

      WIREMAP_4P_SHIELD           = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze
      WIREMAP_4P                  = [1, 2, 3, 4, 5, 6, 7, 8, 0].freeze
      WIREMAP_4P_CROSSOVER_SHIELD = [3, 6, 1, 4, 5, 2, 7, 8, 9].freeze
      WIREMAP_4P_CROSSOVER        = [3, 6, 1, 4, 5, 2, 7, 8, 0].freeze
      WIREMAP_2P_SHIELD           = [1, 2, 3, 0, 0, 6, 0, 0, 9].freeze
      WIREMAP_2P                  = [1, 2, 3, 0, 0, 6, 0, 0, 0].freeze
      WIREMAP_2P_CROSSOVER_SHIELD = [3, 6, 1, 0, 0, 2, 0, 0, 9].freeze
      WIREMAP_2P_CROSSOVER        = [3, 6, 1, 0, 0, 2, 0, 0, 0].freeze
      WIREMAP_ROLLOVER_SHIELD     = [8, 7, 6, 5, 4, 3, 2, 1, 9].freeze
      WIREMAP_ROLLOVER            = [8, 7, 6, 5, 4, 3, 2, 1, 0].freeze
      WIREMAP_SHORTED             = [0, 0, 0, 0, 0, 0, 0, 0, 0].freeze

      WIREMAP_TYPE = { WIREMAP_4P_SHIELD => '4 Pair (S)',
                       WIREMAP_4P => '4 Pair',
                       WIREMAP_4P_CROSSOVER_SHIELD => '4 Pair Crossover (S)',
                       WIREMAP_4P_CROSSOVER => '4 Pair Crossover',
                       WIREMAP_2P_SHIELD => '2 Pair (S)',
                       WIREMAP_2P => '2 Pair',
                       WIREMAP_2P_CROSSOVER_SHIELD => '2 Pair Crossover (S)',
                       WIREMAP_2P_CROSSOVER => '2 Pair Crossover',
                       WIREMAP_ROLLOVER_SHIELD => 'Rollover (S)',
                       WIREMAP_ROLLOVER => 'Rollover',
                       WIREMAP_SHORTED => 'Shorted' }.freeze
    end
  end
end
