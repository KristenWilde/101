def permutations(array)
  return array if array.size == 1
  
  sub_permutations = [[array[0], array[1]], [array[1], array[0]]]
  sub_array_size = 2
  
  while sub_array_size < array.size do
    element = array[sub_array_size]
    results = []

    sub_permutations.each do |sub_array|
      insert_element_at_each_index(element, sub_array).each do |little_array|
        results << little_array
      end
    end
    sub_array_size += 1
    sub_permutations = results.uniq
  end
  
  sub_permutations
end

def insert_element_at_each_index(element, sub_array)
  new_array = []
  0.upto(sub_array.size) do |idx|
    new_array << sub_array.clone.insert(idx, element)
  end
  new_array.uniq
end

test = [1, 2, 3, 4, 5, 6]
results = permutations([1, 2, 3, 4, 5, 6])
p results.size
p test
p results

