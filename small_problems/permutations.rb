def permutations(array)
  results = []
  array = array.clone
  
  sub_array_size = 2  # start with last 2 elements
  while sub_array_size < array.size
    
    arr = array.last(2) # getting a sub-array
    element = array[-sub_array_size - 1] # getting the element to insert
    #6.times do |count|
    
    

    results_for_sub_array = []
    counter = 0  
    while counter <= sub_array_size do
      
      result = nil
      index = 0
      while index <= sub_array_size do
        result = arr.clone.insert(index, element)
        results_for_sub_array << result
        index += 1
      end

      arr = result.clone.last(2)
      element = result.first
      counter += 1
    end
    
    results << results_for_sub_array.clone.uniq
    
    
  #   p results
     sub_array_size += 1
  end

  results
end


p permutations([1, 2, 3]).length # should be 24 but it's 12. Need to add recursion.
p permutations([1, 2, 3])