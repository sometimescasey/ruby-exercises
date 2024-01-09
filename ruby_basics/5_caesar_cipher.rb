# ASCII:
# Uppercase A-Z runs 65 to 90
# Lowercase a-z runs 97 to 122

LOWER_A = 97
LOWER_Z = 122
UPPER_A = 65
UPPER_Z = 90

def char_offset(char, offset, start_ord, end_ord)
  new_ord = start_ord + ((char.ord - start_ord + offset) % (end_ord - start_ord + 1))
  new_ord.chr
end

def cased_offset(char, offset)
  if char.ord.between?(UPPER_A, UPPER_Z)
    char_offset(char, offset, UPPER_A, UPPER_Z)
  elsif char.ord.between?(LOWER_A, LOWER_Z)
    char_offset(char, offset, LOWER_A, LOWER_Z)
  else
    # some other char; do nothing
    char
  end
end

def caesar_cipher(string, offset)
  (string.chars.map { |char| cased_offset(char, offset) }).join
end

# p caesar_cipher('What a string!', 5)
