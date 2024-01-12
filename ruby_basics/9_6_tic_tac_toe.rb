# board needs 9 squares
# win conditions: 3 cols, 3 rows, 2 diags. code this once and use for both x and o
# each player needs to be able to play
# play(square, from 1-9)
# if empty, fill it
# if filled, reject and allow user to try again
# v1: x goes first

# class Board
class Board
  attr_reader :map

  def initialize
    @map = (1..9).to_a.each_with_object({}) { |n, hash| hash[n] = nil }
  end
end

board = Board.new
p board
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
