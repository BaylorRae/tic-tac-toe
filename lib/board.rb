require 'terminal-table'

class Board
  attr_reader :current_player, :squares

  PLAYER_1 = 'x'
  PLAYER_2 = 'o'

  WIN_STATES = [
      # horizontal
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],

      # vertical
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],

      # diagonal
      [0, 4, 8],
      [6, 4, 2]
  ]

  def initialize
    @current_player = PLAYER_1
    @squares = [nil] * 9
  end

  def draw
    puts Terminal::Table.new rows: sliced_squares
  end

  def make_move(position)
    return false unless valid_move?(position)
    squares[position] = current_player
    next_player
  end

  def winner
    winner = WIN_STATES.find do |state|
      values = squares.values_at(*state).compact
      values.length == 3 && values.all? { |x| x == values[0] }
    end

    return nil unless winner

    squares[winner[0]]
  end

  def game_over?
    !(squares - [nil]).empty?
  end

  def draw?
    game_over? && winner.nil?
  end

  private

  def sliced_squares
    squares.each_slice(3).map { |r| r }
  end

  def next_player
    @current_player = @current_player == PLAYER_1 \
      ? PLAYER_2
      : PLAYER_1
  end

  def valid_move?(position)
    squares[position].nil?
  end

end
