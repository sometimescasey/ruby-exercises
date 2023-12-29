def line()
    puts '-'*5
end

family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }

sisters = family.fetch(:sisters)
brothers = family.fetch(:brothers)

siblings = sisters + brothers
puts siblings
puts '-'*5

siblings = family.select{|k,v| [:brothers, :sisters].include?(k)}.values.flatten
puts siblings

line()

def print_keys(hash)
    puts hash.keys
end

def print_values(hash)
    puts hash.values
end

def print_both(hash)
    hash.each do |k,v|
        puts k
        puts v
    end
end

my_hash = {
    boot: 'leg',
    cat: 'fish',
    non: 'chalant'
}

print_keys(my_hash)
line()
print_values(my_hash)
line()
print_both(my_hash)
