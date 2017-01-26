def permutations(array)
  array = array.clone
  return array if array.size == 1
  
  sub_array_size = 1  
  arr = array.take(sub_array_size) 

    element = array[sub_array_size] # getting the element to insert

    sub_array_permutations = insert_at_each_index(element, arr)

    return sub_array_permutations if array.size == 2

    sub_array_size += 1
    element = array[sub_array_size]
    
    next_round = []
    sub_array_permutations.each do |mini_array|
      insert_at_each_index(element, mini_array).each do |little_array|
        next_round << little_array
      end
    end      
    
    next_round.uniq!
    return next_round if array.size == 3
    
    sub_array_size += 1
    element = array[sub_array_size]
    
    last_round = []
    next_round.each do |mini_array|
      insert_at_each_index(element, mini_array).each do |little_array|
        last_round << little_array
      end
    end      
    
    last_round.uniq!

    #sub_array_size += 1
    
  # end

  #results
end

def insert_at_each_index(element, sub_array)
  array_of_arrays = []
  counter = 0  
  arr = sub_array
  while counter <= sub_array.size do
  
    result = nil
    index = 0
    while index <= sub_array.size do
      result = arr.clone.insert(index, element)
      array_of_arrays << result.clone
      index += 1
    end

    arr = result.clone.last(sub_array.size)
    element = result.first
    counter += 1
  end
  
  array_of_arrays.uniq!
  # returns an array of arrays. Size of each is sub_array.size + 1.
end

p permutations([1, 2])
p permutations([1, 2]).size
p permutations([1, 2, 3])
p permutations([1, 2, 3]).size
p permutations([1, 2, 3, 4])
p permutations([1, 2, 3, 4]).size