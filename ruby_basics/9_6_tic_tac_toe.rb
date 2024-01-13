# frozen_string_literal: true

# Class containing everything needed for a tic-tac-toe board.
class Board
  def initialize
    @grid = (1..9).to_a.each_with_object({}) { |n, hash| hash[n] = nil }
    @turns = 0
    @turn_symbol = 'o'
  end

  def run_game
    puts "Enter 'help' for help.\n"

    win = false
    until win || @turns == 9
      @turn_symbol = (@turn_symbol == 'x' ? 'o' : 'x')
      win = prompt_for_turn
      @turns += 1
    end

    print_board
    puts win ? "#{@turn_symbol} has won" : "It's a draw"
  end

  private

  attr_accessor :grid, :turns, :turn_symbol

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

  def collect_move
    print "\nPlayer #{turn_symbol} - make your move (1 to 9): "
    gets.chomp
  end

  def handle_move(number)
    # Returns true if the move was successful, false otherwise.
    if (1..9).to_a.include?(number)
      true if fill_square(number)
    else
      puts 'That is not a valid entry.'
      false
    end
  end

  # rubocop:disable Metrics/MethodLength
  def prompt_for_turn
    print_board
    square_played = false

    until square_played
      number = collect_move

      if number.downcase.strip == 'help'
        print_help
        next
      else
        number = number.to_i
      end

      square_played = handle_move(number)
    end
    check_for_win(turn_symbol)
  end
  # rubocop:enable Metrics/MethodLength

  def fill_square(number)
    # Returns true and fills the square if it's empty, false otherwise.
    if grid.key?(number) && grid[number].nil?
      grid[number] = turn_symbol
      true
    else
      puts "Square #{number} is occupied, pick another."
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
    print "\n"
    [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ].each { |r| print_row(r) }
    print "\n"
  end

  def print_help
    puts "\nThe squares are numbered as follows:"
    puts '[1 2 3]'
    puts '[4 5 6]'
    puts '[7 8 9]'
    puts 'The game ends automatically if a player wins, or if there is a draw.'
    puts "A player wins by getting 3 of their symbol in a line (a row, a column, or a diagonal).\n"
  end
end

board = Board.new
board.run_game
