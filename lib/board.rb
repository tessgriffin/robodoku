require_relative 'row'

class Board
  attr_accessor :board

  def initialize
    @board= Array.new(9, Row.new.row)
  end
end