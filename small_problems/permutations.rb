def permutations(array)
  array = array.clone
  return array if array.size == 1
  
  sub_array_size = 1  
  arr = array.take(sub_array_size) 
  element = array[sub_array_size]

  sub_array_permutations = insert_at_each_index(element, arr)
  
  sub_array_size = 2
  while sub_array_size < array.size do

    element = array[sub_array_size]
    
    next_round = []
    sub_array_permutations.each do |mini_array|
      insert_at_each_index(element, mini_array).each do |little_array|
        next_round << little_array
      end
    end      

    sub_array_size += 1
    sub_array_permutations = next_round.uniq!
  end
  sub_array_permutations
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
end

p permutations([1, 2])
p permutations([1, 2]).size
p permutations([1, 2, 3])
p permutations([1, 2, 3]).size
p permutations([1, 2, 3, 4])
p permutations([1, 2, 3, 4]).size
p permutations([1, 2, 3, 4, 5])
p permutations([1, 2, 3, 4, 5]).size