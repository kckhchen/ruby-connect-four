# frozen_string_literal: true

require 'spec_helper'

describe Board do
  describe '#initialize' do
    it 'creates a grid with 6 rows and 7 columns' do
      board = Board.new

      expect(board.grid.length).to eql(6)
      expect(board.grid[0].length).to eql(7)
    end

    it 'starts with the grid entirely empty' do
      board = Board.new

      expect(board.grid.flatten).to all(be_nil)
    end
  end

  describe '#stack' do
    it 'should have pieces fall to the bottom when the column is clear' do
      board = Board.new
      board.stack(1, 'red')
      expect(board.grid[5][1]).to eql('red')
    end

    it 'should have piece fall on another piece if there is another piece underneath' do
      board = Board.new
      board.stack(1, 'red')
      board.stack(1, 'blue')
      expect(board.grid[4][1]).to eql('blue')
    end

    it 'should not allow out-of-bound piece placement' do
      board = Board.new
      expect { board.stack(7, 'red') }.to raise_error(IndexError)
    end

    it 'should allow to stack to the fullest' do
      board = Board.new
      6.times { |i| board.stack(1, i) }
    end

    it 'should not allow stacking a piece on a full column' do
      board = Board.new
      6.times { |i| board.stack(1, i) }
      expect { board.stack(1, 'red') }.to raise_error(IndexError)
    end
  end

  describe 'winner' do
    it 'should return nil when the board is empty' do
      board = Board.new
      expect(board.winner).to be_nil
    end

    it 'should return the winner when 4 are in a horizontal line' do
      board = Board.new
      4.times { |i| board.stack(i, 'red') }
      expect(board.winner).to eql('red')
    end

    it 'should return the winner when 4 are in a vertical line' do
      board = Board.new
      4.times { board.stack(0, 'red') }
      expect(board.winner).to eql('red')
    end

    it 'should return the winner when 4 are in a diagonal line' do
      board = Board.new
      board.grid[0][0] = 'red'
      board.grid[1][1] = 'red'
      board.grid[2][2] = 'red'
      board.grid[3][3] = 'red'
      expect(board.winner).to eql('red')
    end

    it 'should return the winner when 4 are in an anti-diagonal line' do
      board = Board.new
      board.grid[0][3] = 'red'
      board.grid[1][2] = 'red'
      board.grid[2][1] = 'red'
      board.grid[3][0] = 'red'
      expect(board.winner).to eql('red')
    end
  end

  describe '#over?' do
    it 'should return false if the board is empty' do
      board = Board.new
      expect(board.over?).to be false
    end

    it 'should return false if there has not been a winner' do
      board = Board.new
      board.stack(1, 'red')
      board.stack(2, 'blue')
      expect(board.over?).to be false
    end
    it 'should return true if there is a winner' do
      board = Board.new
      4.times { board.stack(0, 'red') }
      expect(board.over?).to be true
    end
    it 'should return true if the board is full but no winner' do
      board = Board.new
      board.grid.each_with_index do |row, r|
        row.each_index do |c|
          row[c] = "#{r}#{c}"
        end
      end
      expect(board.over?).to be true
    end
  end
end
