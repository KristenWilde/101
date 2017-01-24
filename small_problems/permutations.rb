require 'pry'

def permutations(array)
  results = []
  counter = 0
  arr = array.clone
  while counter < array.size do
    element = arr.shift
    result = nil
    index = 0
    while index < array.size do
      result = arr.clone.insert(index, element)
      results << result
      index += 1
    end
    arr = result
    counter += 1
  end
  results.uniq  #.keep_if {|arr| arr.length == array.size }
end             # I'm not understanding how shorter arrays are in the results.

p permutations([1, 2, 3])