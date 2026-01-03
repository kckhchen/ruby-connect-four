# frozen_string_literal: true

require_relative 'lib/board'

puts '--- Testing Board Display ---'
board = Board.new

# Set up a fake scenario
board.stack(0, '🔴')
board.stack(0, '🟡')
board.stack(1, '🔴')

# Print it
board.display
