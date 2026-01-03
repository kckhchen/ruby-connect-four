# frozen_string_literal: true

require_relative 'board'

# The main game logic for connect-four
class Game
  attr_reader :board, :turn

  def initialize
    @board = Board.new
    @turn = '🔴'
  end

  def play
    puts 'Welcome to the connect-four game!'
    until @board.over?
      @board.display
      play_turn
      switch_player
    end

    @board.display
    announce_result
  end

  private

  def play_turn
    loop do
      puts "It's #{@turn}'s turn! Enter a column (0-6):"
      placement = gets.chomp
      unless placement.match?(/^\d$/)
        puts 'Please enter a valid number between 0-6.'
        next
      end
      placement = placement.to_i

      begin
        @board.stack(placement, @turn)
        break
      rescue IndexError => e
        puts "Invalid move: #{e.message} Please try again."
      end
    end
  end

  def switch_player
    @turn = @turn == '🔴' ? '🟡' : '🔴'
  end

  def announce_result
    winner = @board.winner
    if winner
      puts "#{winner} won!"
    else
      puts "It's a draw!"
    end
  end
end
