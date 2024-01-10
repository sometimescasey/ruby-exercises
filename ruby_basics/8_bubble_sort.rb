def bubble_sort(list)
  iteration = 0
  while iteration < list.length
    swapped = false
    (0..list.length - 2 - iteration).to_a.each do |i| # On the n-th iteration, the n-last items are sorted
      next unless list[i] > list[i + 1]

      big = list[i]
      list[i] = list[i + 1]
      list[i + 1] = big
      swapped = true
    end
    break if swapped == false # If a swap is not made during an iteration, the list is sorted

    iteration += 1
  end
  list
end

list = [4, 3, 78, 2, 0, 2]
p bubble_sort(list)

list = [1, 2, 3, 4, 5]
p bubble_sort(list)

list = [5, 4, 3, 2, 1]
p bubble_sort(list)

list = [2, 1, 1, 1, 1]
p bubble_sort(list)
