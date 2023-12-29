def create_favorite_hash(color, number)
  # return a hash with the following key/value pairs:
  # key of color (as a symbol) with value of the color argument
  # key of number (as a symbol) with the value of the number argument

  return {
    color: color,
    number: number
  }

end

def favorite_color(favorite_hash)
  # return the value of the color key
  return favorite_hash[:color]
end

def favorite_number(favorite_hash)
  # use #fetch to return the value of the number key or 42 if the key is not found
  favorite_hash.fetch(:number, 42)
end

def update_favorite_movie(favorite_hash, movie)
  # Step 1: add/update the key of movie (as a symbol)
  favorite_hash[:movie] = movie

  # Step 2: return the hash (because Step 1 returns the value of the movie key)
  favorite_hash
end

def remove_favorite_number(favorite_hash)
  # Step 1: delete the number data
  favorite_hash.delete(:number)

  # Step 2: return the hash (because Step 1 returns the value of the number key)
  favorite_hash
end

def favorite_categories(favorite_hash)
  # return the keys of favorite_hash
  favorite_hash.keys
end

def favorite_items(favorite_hash)
  # return the values of favorite_hash
  favorite_hash.values
end

def merge_favorites(original_hash, additional_hash)
  # merge the two hashes: original_hash and additional_hash
  return original_hash.merge(additional_hash)
end
