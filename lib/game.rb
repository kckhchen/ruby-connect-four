# frozen_string_literal: true

require_relative 'board'

# The main game logic for connect-four
class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end
end
