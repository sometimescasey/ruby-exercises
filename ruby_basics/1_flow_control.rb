def cap_if_long(word)
	return word.length > 10 ? word.upcase : word
end

puts cap_if_long("boom")
puts cap_if_long("crabmeatistasty")

5.times do |i|
	puts "#{i} zombies incoming"
end


5.upto(10) { |num| puts "#{num}"}

def mutate(arr)
	return arr.pop
end

def not_mutate(arr)
	return arr.select { |n| n > 3 }
end

arr = (0..5).to_a

print("#{"-"*5}\n")
print(arr)
print mutate(arr)
print(arr)
print not_mutate(arr)
print(arr)
