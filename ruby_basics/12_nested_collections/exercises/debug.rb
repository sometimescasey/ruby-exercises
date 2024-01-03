require_relative 'nested_array_exercises'

test_array = ["a", nil, "b"]

sum = reduce_row(test_array)

p sum

test_array_2 = [
	{name: "Ruby", is_my_favorite: false},
	{name: "Perl", is_my_favorite: false},
]

fav = find_favorite(test_array_2)
p fav
