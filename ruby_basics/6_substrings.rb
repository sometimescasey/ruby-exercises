def substrings(string, dictionary)
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

dictionary = %w[below down go going horn how howdy it i low own part partner sit]
p substrings('below', dictionary)
p '-' * 5
p substrings("Howdy partner, sit down! How's it going?", dictionary)
