require 'terminal-table'

class Board
  attr_reader :current_player, :squares

  PLAYER_1 = 'x'
  PLAYER_2 = 'o'

  def initialize
    @current_player = PLAYER_1
    @squares = ['-'] * 9
  end

  def draw
    puts Terminal::Table.new rows: sliced_squares
  end

  def make_move(position)
    return false unless valid_move?(position)
    squares[position] = current_player
    next_player
  end

  def game_over?
    !(squares - ['-']).empty?
  end

  private

  def sliced_squares
    squares.each_slice(3).map { |r| r }
  end

  def next_player
    @current_player = @current_player == PLAYER_1 ? PLAYER_2 : PLAYER_1
  end

  def valid_move?(position)
    squares[position] == '-'
  end

end
