# frozen_string_literal: true

# Class containing everything needed for a game of Mastermind.
class Mastermind
  attr_accessor :grid, :turns
  attr_reader :colors, :secret_code, :code_length, :allow_dupes, :guesses

  def initialize
    # TODO: let user set code length, number of guesses, dupes
    @guesses = 10
    @turns = 0
    @code_length = 4
    @colors = 6
    @allow_dupes = false

    @grid = []
    @secret_code = (1..colors).to_a.sample(4)
  end

  def intro_info
    print "Please enter your guess in the form of #{code_length} digits between 1 and #{colors}.\n"
    print "The game will respond with 2 numbers: [elements in correct position, elements in the set].\n"
    print "I.e. if the secret code is 1234, and you make the guess 1243, the game will return [2,4].\n"
  end

  def valid_guess?(guess)
    # Guess must have same number of digits as code_length
    # Guess can't contain dupes if self.allow_dupes is false
    # Guess must not contain numbers that aren't valid options
    # i.e. if the options are 1-6, each element of the guess must be in [1,2,3,4,5,6]
    guess.chars.length == code_length \
    && (allow_dupes ? true : guess.chars.uniq == guess.chars) \
    && guess.chars.all? { |c| (1..colors).to_a.include?(c.to_i) }
  end

  def prompt_for_guess
    # Prompt the user for a guess in the form of a string of digits, i.e. 5480
    print "\n#{guesses - turns} guesses remaining."
    print "\nYour guess: "
    guess = gets.chomp

    # for debug
    # guess = '1234'

    print valid_guess?(guess) ? nil : 'Invalid guess, try again.'
    print "\n"

    valid_guess?(guess) ? process_guess(guess) : false
  end

  def process_guess(guess)
    # Find the number of correct elements, and the number of correct elements in the right place.
    # Return true if the user has won, false otherwise

    guess_int_list = guess.chars.map(&:to_i)
    n_intersection = (guess_int_list & secret_code).length
    n_correct = 0
    if n_intersection.positive?
      guess_int_list.each_with_index { |n, i| n == secret_code[i] ? n_correct += 1 : nil }
    end
    result = [n_correct, n_intersection]
    grid.append([guess_int_list, result])
    self.turns += 1
    guess_int_list == secret_code
  end

  def print_board
    print "\n"
    grid.each { |r| print "#{r}\n" }
  end
end

game = Mastermind.new
game.intro_info
win = false
while !win && game.turns < game.guesses
  win = game.prompt_for_guess
  game.print_board
end

print win ? 'You win!' : 'You ran out of guesses'
print "\n"
