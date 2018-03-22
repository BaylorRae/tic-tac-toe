require 'terminal-table'

class Board

  attr_reader :squares

  def initialize
    @squares = (['-'] * 9).each_slice(3).map { |r| r }
  end

  def draw
    puts Terminal::Table.new rows: squares
  end

end
