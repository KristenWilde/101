require 'pry'

# Seeing Stars

def star(width)
  k = (width - 3) / 2
  row_count = 0
  outer = k
  inner = 0
  loop do
    row = " "*(k-outer) + "*" + " "*(k-inner) + "*" + " "*(k-inner) + "*" + " "*(k-outer)
    p row
    row_count += 1
    break if row_count >= (width/2)
    if outer > 0 then outer -= 1
    end
    inner += 1
    # binding.pry
  end
  p "*" * width
  row_count += 1
  while row_count <= width
    row = " "*(k-outer) + "*" + " "*(k-inner) + "*" + " "*(k-inner) + "*" + " "*(k-outer)
    p row
    outer += 1
    inner -= 1
    row_count += 1
  end
end

# star(9)

# Analysis: It works, but these variables are confusing. Launch school's solution
# uses String#center, which is much more efficient, and a variable "distance_from_center".
# They extracted the printing of a line to a method, which is something I thought about
# doing (but didn't because I'd have to give it so many variables.)

# Transpose 3x3

# Build a matrix where each successive element contains the next three objects in the 
# original matrix.

def transpose(matrix)
  new_matrix = [[], [], []]
  matrix.each do |array|
    3.times do |i|
      new_matrix[i] << array[i]
    end
  end
  new_matrix
end

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

# new_matrix = transpose(matrix)

# p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
# p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]

# Transpose MxN

def transpose(matrix)
  new_matrix = []
  matrix[0].size.times { |_| new_matrix.push(Array.new) }
  matrix.each do |array|
    # while iterating through array,
    # the next spot in each item in new_matrix gets successive items from array.
    array.size.times do |i|
      new_matrix[i] << array[i]
    end
  end
  new_matrix
end


# Rotating Matrices

def rotate90(matrix)
  new_matrix = []
  matrix[0].size.times { |_| new_matrix.push(Array.new) }
  matrix.reverse_each do |array|
    # while iterating through array,
    # the next spot in each item in new_matrix gets successive items from array.
    array.size.times do |i|
      new_matrix[i] << array[i]
    end
  end
  new_matrix
end

matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

# new_matrix1 = rotate90(matrix1)
# new_matrix2 = rotate90(matrix2)
# new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))

# p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
# p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
# p new_matrix3 == matrix2

# Permutations

# Add to the nested_array: 
  # - array as is
  # - make a new array, swapping position of two elements. (Reassigning, delete/insert)
  #   - get last value, insert at each position.
  #   - after inserting at each new position, get new last value and rearrange. 
  #    (looping within loops - possibly a recursive method?)
  # - uniq to remove duplicates.
  
def swap(arr, x, y)
  array = arr.clone
  array[x], array[y] = array[y], array[x]
  array
end
  
def permutations(array)
  nested_array = Array.new
  0.upto(array.size-1) do |j|
    permutation = nil
    0.upto(array.size-1) do |i|
      permutation = swap(array, i, j)
      nested_array << permutation
    end
  end
  nested_array.uniq
end

#p permutations([1, 2, 3])
# => [[1, 2, 3], [2, 1, 3], [3, 2, 1], [1, 3, 2]], missing two. 

# Fix the Bug

def my_method(array)
  if array.empty?
    []
  elsif array.size >= 2
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end

# p my_method([])
# p my_method([3])
# p my_method([3, 4])
# p my_method([5, 6, 7])

# Merge sorted Lists

# Look at next element in each array, and add the larger to a new array.
# Use a counter variable to keep track of where we are in each array.
# (Or alternatively, clone the arrays and then chop them up.)

def merge(arr1, arr2)
  result = []
  counter1 = 0
  counter2 = 0
  loop do
    break if counter1 >= arr1.length && counter2 >= arr2.length
    if arr1[counter1] == nil 
      result << arr2[counter2]
      counter2 += 1
    elsif arr2[counter2] == nil
      result << arr1[counter1]
      counter1 += 1
    elsif arr1[counter1] <= arr2[counter2]
      result << arr1[counter1]
      counter1 += 1
    else 
      result << arr2[counter2]
      counter2 += 1
    end
  end
  result
end

# p merge([1, 5, 9], [2, 6, 8]) #== [1, 2, 5, 6, 8, 9]
# p merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
# p merge([], [1, 4, 5]) == [1, 4, 5]
# p merge([1, 4, 5], []) == [1, 4, 5]

# Merge sort

def merge_sort(array)
  split_index = array.size / 2
  arr1 = array[0..split_index]
  arr2 = array[split_index..-1]
  binding.pry
  merged_array = merge(arr1, arr2)
  # check to see if array is sorted; otherwise recursively call merge_sort on merged_array.
  sorted = false
  merged_array.each_with_index do |el, indx|
    sorted = true if !merged_array[indx + 1] 
    if el < merged_array[indx + 1] then next
    else break
    end
  end
  sorted ? merged_array : merge_sort(merged_array)
end

# p merge_sort([9, 5, 7, 1]) #== [1, 5, 7, 9]
# p merge_sort([5, 3]) #== [3, 5]
# merge_sort([6, 2, 7, 1, 4]) #== [1, 2, 4, 6, 7]
# merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
# merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]

# Egyptian Fractions

def egyptian(rational)
  array = []
  n = 1
  remaining = rational
  until remaining == 0
    if remaining - Rational(1, n) >= 0
      array << n
      remaining = remaining - Rational(1, n)
    end
    n += 1
  end
  array
end 

# p egyptian(Rational(2))
# p egyptian(Rational(137, 60))
# p egyptian(Rational(3))

def unegyptian(denominators)
  sum = Rational(0)
  denominators.each do |denominator|
    sum += Rational(1, denominator)
  end
  sum
end

# p unegyptian([1, 2, 3, 6])
# p unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
# p unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
# p unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
# p unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
# p unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
# p unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
# p unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
# p unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)