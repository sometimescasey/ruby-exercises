# frozen_string_literal: true

# Class containing everything needed for a game of Mastermind.
class Mastermind
  attr_accessor :grid, :turns, :secret_code
  attr_reader :colors, :code_length, :allow_dupes, :guesses

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

  def collect_secret_from_user
    code_set = false
    until code_set
      print "Please enter your secret in the form of #{code_length} digits between 1 and #{colors}.\n"
      print "\nYour secret code: "
      sec = gets.chomp

      # sec = '5612' # for debug

      code_set = valid_guess?(sec)
      print code_set ? nil : 'Invalid code, please try again.'
    end
    self.secret_code = sec.chars.map(&:to_i)
  end

  def run_computer_guessing
    # TODO: this needs to be tested to see if actually working
    # Knuth algorithm

    # Create the set S of 1296 possible codes, 1111,1112,.., 6666.
    colors_array = (1..colors).to_a
    possible = if allow_dupes
                 colors_array.repeated_permutation(code_length)
               else
                 colors_array.permutation(code_length)
               end

    # Start with initial guess 1122 (Knuth gives examples showing that some other first guesses such as 1123, 1234 do not win in five tries on every code).
    # initial_guess = (1..code_length).map.with_index { |_n, i| i < code_length / 2 ? 1 : 2 }.concat
    initial_guess = [1, 2, 3, 4] # for non-dupe case
    current_guess = initial_guess
    s_list = possible

    while turns < guesses
      # Play the guess to get a response of colored and white pegs.
      print "Computer guesses #{current_guess}\n"
      response = _process_guess_array_to_result(current_guess)

      # remove the guess from possible
      possible = possible.filter { |i| i != current_guess }
      # If the response is four colored pegs the game is won, the algorithm terminates.
      return true if response[0] == code_length

      # Otherwise, remove from S any code that would not give the same response if it (the guess) were the code.
      s_list = s_list.filter { |guess| _process_guess_array_to_result(current_guess, secret: guess) == response }
      # Apply minimax technique to find a next guess as follows:
      # For each possible guess, that is, any unused code of the 1296 not just those in S,
      # calculate how many possibilities in S would be eliminated
      # for each possible colored/white peg score. # !!!!<-- TODO MISSED THIS
      # The score of a guess is the minimum number of possibilities it might eliminate from S.
      possible_scores = possible.map do |guess|
        # response = _process_guess_array_to_result(guess)
        # TODO!!!!!!
        # create list of all possible responses
        # get eliminated score for each, and keep the min
        all_responses = (0..code_length).to_a.repeated_permutation(2).filter { |r| r[0] <= r[1] }
        lowest_eliminated_score = Float::INFINITY
        all_responses.each do |r|
          # keep a code in S if for the current |guess|,
          # if we use that code as the secret, we get the response |r|
          keep_in_s = s_list.filter { |s| _process_guess_array_to_result(guess, secret: s) == r }
          remove_from_s = s_list.filter { |s| _process_guess_array_to_result(guess, secret: s) != r }
          # guesses_eliminated_from_s = s_list.filter { |s| _process_guess_array_to_result(guess, secret: s) != r }.length
          # The largest value that we encounter for keep_in_s is the worst possible outcome
          # The smallest value that we encounter for remove_from_s is the worst possible outcome
          lowest_eliminated_score = remove_from_s.length if remove_from_s.length < lowest_eliminated_score
        end
        [guess, lowest_eliminated_score]
      end

      # we want to use the guess that has the highest possible worst score
      highest_score = possible_scores.map { |ps| ps[1] }.max
      highest_guesses = possible_scores.filter { |ps| ps[1] == highest_score }.map { |ps| ps[0] }

      # From the set of guesses with the maximum score select one as the next guess, choosing a member of S whenever possible.
      # (Knuth follows the convention of choosing the guess with the least numeric value e.g. 2345 is lower than 3456.
      # Knuth also gives an example showing that in some cases no member of S will be among the highest scoring guesses
      # and thus the guess cannot win on the next turn yet will be necessary to assure a win in five.)

      # intersect highest_guesses with S
      highest_guesses_in_s_list = highest_guesses.intersection(s_list)
      next_guess = if highest_guesses_in_s_list.length.positive?
                     highest_guesses_in_s_list.min
                   else
                     highest_guesses.min
                   end

      # Repeat from step 3.

      # NOTE: TO SELF: i feel like I need to be doing something with 'possible'
      current_guess = next_guess
      self.turns += 1
    end
    false
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

  def _process_guess_array_to_result(guess_int_list, secret: secret_code)
    n_intersection = (guess_int_list & secret_code).length
    n_correct = 0
    if n_intersection.positive?
      guess_int_list.each_with_index { |n, i| n == secret[i] ? n_correct += 1 : nil }
    end
    [n_correct, n_intersection]
  end

  def process_guess(guess)
    # Find the number of correct elements, and the number of correct elements in the right place.
    # Return true if the user has won, false otherwise

    guess_int_list = guess.chars.map(&:to_i)
    result = _process_guess_array_to_result(guess_int_list)
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

win = false

if ARGV[0] == 'c' # run computer guessing mode
  ARGV.clear
  player = 'Computer'
  game.collect_secret_from_user
  win = game.run_computer_guessing

else
  player = 'You'
  game.intro_info
  while !win && game.turns < game.guesses
    win = game.prompt_for_guess
    game.print_board
  end
end

print win ? "#{player} wins!" : "#{player} ran out of guesses! It was #{game.secret_code}"
print "\n"
