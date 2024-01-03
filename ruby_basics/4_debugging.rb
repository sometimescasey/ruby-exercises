

def isogram?(string)
  original_length = string.length
  string_array = string.downcase.split
  if string_array.length != 1
    puts 'Please provide exactly one word.'
    return nil
  end
  unique_length = string.downcase.chars.uniq.length
  original_length == unique_length
end

puts isogram?('Odifffn')
