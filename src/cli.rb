require 'cli/ui'
require 'terminal-table'
require './src/pockethernet'

CLI::UI::StdoutRouter.enable

Pockethernet::Engine::Transport.connect('')

CLI::UI::Frame.open('Pockthernet') do
  tests = CLI::UI.ask('Which tests would you like to run?', 
                      options: %w[Wiremap NIL], 
                      multiple: true)

  tests.each do |test|
    next unless test == 'Wiremap'

    spinners = CLI::UI::SpinGroup.new

    wiremap_response = {}
    spinners.add('Wiremap') do |_spinner|
      Pockethernet::Engine::Do.phyconf
      wiremap_response = Pockethernet::Engine::Do.wiremap
      Pockethernet::Engine::Do.phyconf
    end

    spinners.wait

    if wiremap_response[:shorted]
      # Parse shorted wiremap_response
    elsif wiremap_response[:cable_type] == 'Miswire'
      # Parse miswire wiremap_response
      wiremap_values = Pockethernet::Parse::Type::WIREMAP_568A.values[1..-1]
      rows = wiremap_values.zip(wiremap_response[:cable_order])
      table = Terminal::Table.new(title: "Wiremap Results\n(#{wiremap_response[:cable_type]})",
                                  headings: %w[568A Termination],
                                  rows: rows)
      puts table

      wiremap_values = Pockethernet::Parse::Type::WIREMAP_568A.values[1..-2]
      rows = wiremap_values.zip(wiremap_response[:cable_order]).reject { |pair| pair[0] == pair[1] }
      table = Terminal::Table.new(title: "Issue with pairs\n(#{wiremap_response[:cable_type]})",
                                  headings: %w[568A Termination],
                                  rows: rows)
      puts table
    else
      # Parse correct wiremap_response
      wiremap_values = Pockethernet::Parse::Type::WIREMAP_568A.values[1..-1]
      rows = wiremap_values.zip(wiremap_response[:cable_order])
      table = Terminal::Table.new(title: "Wiremap Results\n(#{wiremap_response[:cable_type]})",
                                  headings: %w[568A Termination],
                                  rows: rows)
      puts table
    end
  end
end
