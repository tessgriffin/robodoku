require_relative 'solver'

filename = ARGV[0]
puzzle = File.open(filename)
solver = Solver.new(puzzle)
sectioned = solver.parse_puzzle
assigned = solver.assign_spots(sectioned)
puts solver.solve_puzzle(assigned)
