def permutations(array)
  #results = []
  array = array.clone
  
  sub_array_size = 1  # start with last 2 elements
  arr = array.last(sub_array_size) # getting a sub-array
  # while sub_array_size < array.size

    element = array[-sub_array_size - 1] # getting the element to insert

    sub_array_permutations = insert_at_each_index(element, arr)

    element = array[-sub_array_size - 2]
    
    next_round = []
    sub_array_permutations.each do |mini_array|
      insert_at_each_index(element, mini_array).each do |little_array|
        next_round << little_array
      end
    end      
    
    p next_round.uniq!
    puts next_round.size
      
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

permutations([1, 2, 3])