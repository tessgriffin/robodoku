require_relative 'cell'

class Row
  attr_accessor :row

  def initialize
    @row = Array.new(9, Cell.new.cell)
  end
end