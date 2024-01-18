# frozen_string_literal: true

# Class containing everything needed for a game of Mastermind.
class Mastermind
  attr_accessor :grid
  attr_reader :colors, :secret_code, :allow_dupes

  def initialize
    # TODO: can set code length, number of guesses
    @guesses = 10
    @code_length = 4
    @colors = 6
    @grid = @guesses.times.map { |_x| @code_length.times.map { |_y| nil } }
    @allow_dupes = false # TODO

    @secret_code = (1..colors).to_a.sample(4)
    p 'hi'
  end

  def valid_guess?(guess)
    # Guess must have same number of digits as code_length
    # Guess must not contain numbers that aren't valid options
    # i.e. if the options are 1-6, each element of the guess must be in [1,2,3,4,5,6]
    guess.chars.length == colors && guess.chars.all? do |c|
      (1..colors).to_a.include?(c.to_i)
    end && (allow_dupes ? true : guess.chars.uniq == guess.chars)

    # TODO: handle dupes
  end

  def prompt_for_guess
    # Prompt the user for a guess in the form of a string of digits, i.e. 5480
    print "\nType your guess (i.e. 7395): "
    guess = gets.chomp
    print valid_guess?(guess) ? 'valid' : 'not valid'
  end
end

game = Mastermind.new
game.prompt_for_guess while 1
p 'hi'
