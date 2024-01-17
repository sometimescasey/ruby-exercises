# frozen_string_literal: true

# Class containing everything needed for a game of Mastermind.
class Mastermind
  attr_accessor :grid
  attr_reader :colors, :secret_code

  def initialize
    # TODO: can set code length, number of guesses
    @guesses = 10
    @code_length = 4
    @colors = 6
    @grid = @guesses.times.map { |_x| @code_length.times.map { |_y| nil } }

    @secret_code = (1..colors).to_a.sample(4)
    p 'hi'
  end

  # def generate_code
  #   # TODO: set allow dupes or not
  #   # choose self.code_length numbers from the numbers [1, 2, ... self.colors]
  #   (1..colors).to_a.sample(4)
  # end
end

game = Mastermind.new
p 'hi'
