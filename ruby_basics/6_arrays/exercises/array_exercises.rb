def nil_array(number)
  # return an array containing `nil` the given number of times
  return Array.new(number)
end

def first_element(array)
  return array.first
end

def third_element(array)
  return array[2]
end

def last_n_elements(array, n)
  # Return the last n elements of an array, or all of them if the array is shorter than that
  if n > array.length
    return array
  else
    indices = (-n..-1)
    return indices.map {|i| array[i]}
  end
end

def last_three_elements(array)
  return last_n_elements(array, 3)
end

def add_element(array)
  # add an element (of any value) to the array
  array.push(nil)
end

def remove_last_element(array)
  # Step 1: remove the last element from the array
  array.pop
  # Step 2: return the array (because Step 1 returns the value of the element removed)
  array
end

def remove_first_n_elements(array, n)
  # Remove the first n elements of an array, or all of them if the array is shorter than that
  if n >= array.length
    return []
  else
    n.times { array.shift }
    return array
  end
end

def remove_first_three_elements(array)
  # Step 1: remove the first three elements
  return remove_first_n_elements(array, 3)
  # Step 2: return the array (because Step 1 returns the values of the elements removed)
  
end

def array_concatenation(original, additional)
  # return an array adding the original and additional array together
  return original + additional
end

def array_difference(original, comparison)
  # return an array of elements from the original array that are not in the comparison array
  return original.select {|i| !comparison.include?(i)}
end

def empty_array?(array)
  # return true if the array is empty
  return array.length == 0
end

def reverse(array)
  # return the reverse of the array
  return array.reverse
end

def array_length(array)
  # return the length of the array
  return array.length
end

def include?(array, value)
  # return true if the array includes the value
  return array.include?(value)
end

def join(array, separator)
  # return the result of joining the array with the separator
  return array.join(separator)
end
