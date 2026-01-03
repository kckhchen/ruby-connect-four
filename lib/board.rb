# frozen_string_literal: true

# A connect-four board.
class Board
  attr_reader :grid

  ROWS = 6
  COLS = 7

  def initialize
    @grid = Array.new(ROWS) { Array.new(COLS) }
  end

  def stack(col, piece)
    raise IndexError, 'Please input 0-6 only.' unless col.between?(0, COLS - 1)
    raise IndexError, 'The column is full!' unless @grid[0][col].nil?

    ROWS.times do |row|
      next if can_fall?(row, col)

      @grid[row][col] = piece
      break
    end
  end

  def winner
    check_lines(@grid) || check_lines(@grid.transpose) || check_lines(skew_t(1)) || check_lines(skew_t(-1))
  end

  def over?
    !!winner || full?
  end

  def display
    @grid.each do |row|
      formatted_row = row.map { |cell| cell.nil? ? '⚫' : cell }
      puts formatted_row.join(' | ')
    end
    puts '--------------------------------'
  end

  private

  def can_fall?(row, col)
    return false if row + 1 == ROWS

    @grid[row + 1][col].nil?
  end

  def check_lines(lines)
    lines.each do |line|
      line.each_cons(4) do |subarr|
        next if subarr.include?(nil) || subarr.uniq.length != 1

        return subarr[0]
      end
    end
    nil
  end

  def skew_t(direction)
    skewed = @grid.map.with_index do |row, i|
      k = direction == 1 ? i : (ROWS - 1 - i)
      [nil] * k + row + [nil] * (ROWS - 1 - k)
    end
    skewed.transpose
  end

  def full?
    !@grid[0].include?(nil)
  end
end
