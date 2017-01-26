def missing(array)
  range = array.max - array.min
  full_set = array.min.step(by: 1).take(range)
  full_set.select { |num| !array.include?(num) }
end

p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []