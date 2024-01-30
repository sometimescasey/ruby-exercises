# My own version of Hangman, before reading thr TOP instructions.
# Read a dictionary in from a text file
# Randomly choose a word
# And play Hangman with the computer.

DEFAULT_DICT = './casey_hangman_dict.txt'.freeze
# DEFAULT_DICT = './ruby_basics/casey_hangman_dict.txt'.freeze

class Hangman
  attr_reader :dictionary, :max_errors
  attr_accessor :guessed, :word, :lost, :errors

  def initialize(filepath = DEFAULT_DICT)
    @dictionary = dict_to_list(filepath)
    @word = nil
    @guessed = nil
    @lost = false
    @errors = 0
    @max_errors = 3
  end

  def dict_to_list(filepath)
    # Read a dictionary from a file to a list of strings.
    # One word or phrase per line.
    # Non a-z characters will be stripped.
    f = File.open(filepath)
    phrase_list = []
    while (file_line = f.gets)
      cleaned = clean_line(file_line.chomp)
      phrase_list.append(cleaned) if cleaned
    end
    f.close
    phrase_list
  end

  def clean_line(line)
    # Only accept alphabetical characters, and lowercase the string.
    only_char = line.gsub(/[^a-zA-Z]+/, '')
    char_and_spaces = line.gsub(/[^a-zA-Z\s]+/, '')

    return char_and_spaces.downcase if only_char.length.positive? && char_and_spaces == line.chomp

    nil
  end

  def show_dict
    dictionary.each do |dict_line|
      puts dict_line
    end
  end

  def print_guesses
    guessed.each do |char|
      print char ? " #{char} " : ' _ '
    end
    print "\n"
  end

  def do_guess(letter)
    # Go through word and fill in
    hit = false
    guessed.each_with_index do |_char, i|
      if letter == word[i]
        guessed[i] = letter
        hit = true
      end
    end
    hit
  end

  def set_guessed
    self.guessed = word.chars.map { |char| char == ' ' ? char : nil }
  end

  def guess_whole_word(whole_word_guess)
    whole_word_guess == word
  end

  def game_is_over
    self.lost = true if errors > max_errors
    guessed.join == word or lost == true
  end

  def receive_whole_word
    puts 'Your guess is: '
    whole_word_guess = gets.chomp
    if whole_word_guess == word
      self.guessed = word.chars
    else
      self.lost = true
    end
  end

  def play_game
    self.word = dictionary.sample
    set_guessed
    tried_whole_word = false

    until game_is_over
      puts 'Guess a letter, or enter 0 to guess the whole word: '
      letter = gets.chomp.downcase
      # letter = 'b'
      if letter == '0'
        receive_whole_word
        tried_whole_word = true
      elsif letter.length == 1 && clean_line(letter) == letter
        hit = do_guess(letter)
      else
        puts 'Please enter a single letter between a-z.'
        next
      end

      unless hit || tried_whole_word
        print "There was no #{letter}\n"
        self.errors += 1
      end

      print_guesses
    end

    if lost
      puts "The answer was #{word}\n"
      puts 'You lose :('
    else
      puts 'You win!'
    end
  end
end

hangman = Hangman.new
hangman.play_game

# TODOs

# Block guessing the same letter again
# Draw hangman
# End game when entire man is drawn

# spaces are already "guessed" at the start - done
# Allow user to guess the entire word - done
# End game if the entire word guess is wrong - done
# Keep track of bad guesses - done
# allow max number of bad guesses - done
