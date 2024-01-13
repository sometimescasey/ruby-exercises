# board needs 9 squares
# win conditions: 3 cols, 3 rows, 2 diags. code this once and use for both x and o
# each player needs to be able to play
# play(square, from 1-9)
# if empty, fill it
# if filled, reject and allow user to try again
# v1: x goes first

# class Board
class Board
  attr_reader :grid

  WIN_CONDITIONS = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ].freeze

  def initialize
    @grid = (1..9).to_a.each_with_object({}) { |n, hash| hash[n] = nil }
  end

  # rubocop:disable Metrics/MethodLength
  def prompt_for_turn(symbol)
    # Say "It's player X's turn"
    # Prompt user for which square to play
    # Enter a square from 1 to 9, or type 'help' to get help.

    # The squares are arranged as follows:
    # [1 2 3]
    # [4 5 6]
    # [7 8 9]

    square_played = false

    until square_played

      print "Player #{symbol} - enter the square number (1 to 9) that you wish to play: "
      number = gets.chomp

      # temp for debug
      # number = '2'

      if number.downcase.strip == 'help'
        puts 'TODO replace with help text'
        next
      else
        number = number.to_i
      end

      if (1..9).to_a.include?(number)
        puts ''
        played = play_square(symbol, number)
        if played
          square_played = true
          check_for_win(symbol)
        end
      else
        puts 'That is not a valid entry.'
      end
    end

    check_for_win(symbol)
  end
  # rubocop:enable Metrics/MethodLength

  def play_square(symbol, number)
    # Check if the square is free
    if grid.key?(number) && grid[number].nil?
      grid[number] = symbol
      true
    else
      puts "Square #{number} is already occupied, please pick a different one."
      false
    end
  end

  def check_for_win(symbol)
    square_list = grid.map { |k, v| v == symbol ? k : nil }.filter { |v| !v.nil? }
    WIN_CONDITIONS.any? { |condition| condition.intersection(square_list) == condition }
  end

  def print_row(row)
    row.each { |r| print(grid[r].nil? ? '_ ' : "#{grid[r]} ") }
    print "\n"
  end

  def print_board
    print_row([1, 2, 3])
    print_row([4, 5, 6])
    print_row([7, 8, 9])
    print "\n"
  end

  private # TODO: move everything here

  attr_writer :grid
end

board = Board.new
symbol = 'o'
win = false

turns = 0
until win || turns == 9
  symbol = symbol == 'x' ? 'o' : 'x'
  win = board.prompt_for_turn(symbol)
  board.print_board
  turns += 1
end

puts win ? "#{symbol} has won" : "It's a draw"

# TODO: draw case

# Board has turn: boolean

# has 9 "Squares" - store them in a hash # can get x_list, o_list from this
# don't check for victory until 5 turns have been played
# draw board function

# play(n)
# Board keeps track of the turn and checks if already full

# X = x
# O = o
# square.symbol = X

# Board keeps a list of filled squares by number; i.e. x_fill = [1,3,4]
# x - x  1 2 3
# - x -  4 5 6
# - - -  7 8 9

# Keep a set of win conditions:
# [1,2,3]
# [4,5,6]
# [7,8,9]
# [1,4,7]
# [2,5,8]
# [3,6,9]
# [1,5,9]
# [3,5,7]

# If one of these conditions is ever found in a list after a play, that player wins
# After 9 plays, if nobody has won, it must be a draw
