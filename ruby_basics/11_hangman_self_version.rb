# My own version of Hangman, before reading thr TOP instructions.
# Read a dictionary in from a text file
# Randomly choose a word
# And play Hangman with the computer.

DEFAULT_DICT = './casey_hangman_dict.txt'.freeze
# DEFAULT_DICT = './ruby_basics/casey_hangman_dict.txt'.freeze

class Hangman
  attr_reader :dictionary
  attr_accessor :guessed

  def initialize(filepath = DEFAULT_DICT)
    @dictionary = dict_to_list(filepath)
    @guessed = nil
  end

  def dict_to_list(filepath)
    # Read a dictionary from a file to a list of strings.
    # One word or phrase per line.
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
    only_char.length.positive? ? line.gsub(/[^a-zA-Z\s]+/, '').downcase : nil
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

  def play_game
    # word = dictionary.sample
    word = 'underwhelmed'
    self.guessed = Array.new(word.length, nil)

    while guessed.join != word
      hit = false
      puts 'Guess a letter: '
      letter = gets.chomp.downcase
      # letter = 'u'
      if letter.length == 1 && clean_line(letter) == letter
        # Go through word and fill in
        guessed.each_with_index do |_char, i|
          if letter == word[i]
            guessed[i] = letter
            hit = true
          end
        end
      else
        puts 'Please enter a single letter between a-z.'
        next
      end
      print "There was no #{letter}\n" unless hit
      print_guesses
    end

    puts 'You win!'
  end
end

hangman = Hangman.new
hangman.show_dict
hangman.play_game

# TODOs

# Allow user to guess the entire word
# Block guessing the same letter again
# Keep track of bad guesses
# Draw hangman
# End game when entire man is drawn
