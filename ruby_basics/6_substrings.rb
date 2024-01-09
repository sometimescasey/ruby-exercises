def substrings_overlap(string, dictionary)
  string_as_array = string.downcase.chars
  # for each n-char long word from the dict, scan along string_as_array n-chars at a time
  dictionary.each_with_object(Hash.new(0)) do |word, result|
    first_index = 0
    while (first_index + word.length) <= string_as_array.length
      result[word] += 1 if string_as_array.slice(first_index, word.length) == word.chars
      first_index += 1
    end
  end
end

def substrings_no_overlap(string, dictionary)
  dictionary.each_with_object(Hash.new(0)) do |word, result|
    result[word] += string.downcase.scan(word).length unless string.downcase.scan(word).empty?
  end
end

def substrings(string, dictionary, allow_overlap: true)
  allow_overlap ? substrings_overlap(string, dictionary) : substrings_no_overlap(string, dictionary)
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]
puts substrings('below', dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)

dictionary = %w[oo ooo]
puts substrings('oooo', dictionary) # {"oo"=>3, "ooo"=>2}
puts substrings('oooo', dictionary, allow_overlap: false) # {"oo"=>2, "ooo"=>1}
