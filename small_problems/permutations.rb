def permutations(array)
  results = []
  arr = array.clone
  counter = 0
  
  while counter < array.size do
    element = arr.shift
    result = nil
    index = 0
    while index < array.size do
      result = arr.clone.insert(index, element)
      results << result
      index += 1
    end

    arr = result.clone
    counter += 1
  end

  results.uniq
end

p permutations([1, 2, 3, 4]) 
p permutations([1, 2, 3, 4]).length # should be 24 but it's 12. Need to add recursion.
