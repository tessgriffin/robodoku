require_relative 'board'

class Robodoku
  attr_accessor :puzzle
  attr_reader  :possible

  def initialize(puzzle)
    @puzzle = puzzle
    @possible = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def parse_puzzle
    puzzle_sectioned = []
    puzzle.each_char.each_slice(10) { |section| puzzle_sectioned << section }
    puzzle_sectioned.select { |section| section[0..-2] }
  end

  def assign_spots(puzzle_sectioned)
    new_array = []
    puzzle_sectioned.each_with_index do |row, row_number|
       row.each_with_index do |space, column_number|
         value = space
         new_array << Cell.new(value, row_number, column_number)
       end
     end
     new_array
   end

  def find_empty(puzzle)
    puzzle.detect do |cell|
      cell.value == " "
    end
  end

  def find_new_possibilities(puzzle_row)
    new_possible = possible.reject do |num|
      puzzle_row.any? do |cell|
        num == cell.value.to_i
      end
    end
    new_possible
  end

  def find_row(puzzle, row_num)
    puzzle.select do |cell|
      cell.row_number == row_num.to_i
    end
  end

  def find_column(puzzle, col_num)
    puzzle.select do |cell|
      cell.column_number == col_num
    end
  end

  def find_square(puzzle, sq_num)
    puzzle.select do |cell|
      cell.square_number == sq_num
    end
  end

  def solve_spot(assigned_puzzle, empty_spot)
    row_number = empty_spot.row_number
    row = find_row(assigned_puzzle, row_number)
    row_possibilities = find_new_possibilities(row)

    column_number = empty_spot.column_number
    column = find_column(assigned_puzzle, column_number)
    column_possibilities = find_new_possibilities(column)

    square_number = empty_spot.square_number
    square = find_square(assigned_puzzle, square_number)
    square_possibilities = find_new_possibilities(square)

    (row_possibilities & column_possibilities & square_possibilities).first.to_s
  end

  def solve_puzzle(assigned_puzzle)
    number_of_empty_spots(assigned_puzzle).times do
      empty_spot = find_empty(assigned_puzzle)
      empty_spot.value = solve_spot(assigned_puzzle, empty_spot)
    end
    print_out_puzzle(assigned_puzzle)
  end

  def print_out_puzzle(assigned_puzzle)
    assigned_puzzle.map do |cell|
      cell.value
    end.join
  end

  def number_of_empty_spots(assigned_puzzle)
    assigned_puzzle.reduce(0) do |sum, cell|
      if cell.value == " "
        sum += 1
      end
      sum
    end
  end
end


puzzle2 = File.open('./puzzle5.txt')
robo = Robodoku.new(puzzle2)
sectioned = robo.parse_puzzle
assigned = robo.assign_spots(sectioned)

puts robo.solve_puzzle(assigned)