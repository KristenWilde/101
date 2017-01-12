#1.

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]

puts arr1[2][1][3]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]

puts arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]

puts arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}

puts hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

puts hsh2[:third].keys[0]

#2.

arr1 = [1, [2, 3], 4]
arr1[1][1] = 4
p arr1

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] = 4
p arr2

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] = 4
p hsh1

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[['a']][:a][2] = 4
p hsh2

# 3. a is 2 because reassigning the first element in the array doesn't actually 
#  access a. b is [3, 8] because it was accessed.

# 4. 

hsh = { first: ['the', 'quick'], 
        second: ['brown', 'fox'],
        third: ['jumped'],
        fourth: ['over', 'the', 'lazy', 'dog'] }

vowels_output = ""
VOWELS = %w(a e i o u)

hsh.each do |key, string_array|
  string_array.each do |word|
    word.each_char do |char|
      if VOWELS.include?(char)
        vowels_output << char
      end
    end
  end
end

p vowels_output

# 5.

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

sorted = arr.map { |sub_array| sub_array.sort {|x, y| y <=> x } }

p sorted

# 6.  RECOMMEND AS FEEDBACK.

result = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh| 
  hsh.each_with_object({}) do |(key, val), incremented_hash|
    incremented_hash[key] = val + 1 
  end
end

p result

# 7.

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

result = arr.map do |sub_array|
  sub_array.select do |num|
    num % 3 == 0
  end
end

p result

# 8. write some code that will return a hash where the key is the first item 
#    in each sub array and the value is the second item.

arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

result = arr.each_with_object({}) do |sub_array, new_hash|
  new_hash[sub_array[0]] = sub_array[1]
end

p result

# 9. return a new array containing same sub-arrays as the original but ordered 
#    logically according to the numeric value of the odd integers they contain.

arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

new = arr.sort_by do |sub_arr|
  sub_arr.select {|num| num.odd?}
end

p new

# 10. return an array containing the colors of the fruits and the sizes of the 
#  vegetables. The sizes should be uppercase and the colors should be capitalized.

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

result = hsh.map do |_, attributes|
  if attributes[:type] == 'fruit'
    attributes[:colors].map {|color| color.capitalize }
  elsif attributes[:type] == 'vegetable'
    attributes[:size].upcase
  end
end
p result

# 11. return an array which contains only the hashes where all the integers are even.

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

result = arr.select do |hash|
  hash.values.flatten.all? {|num| num.even? } 
end

other_way = arr.select do |hsh|
  hsh.all? do |_, value|
    value.all? do |num|
      num.even?
    end
  end
end

p result

p other_way

# 12. return a new array containing all of the items in the original array but in a flat structure.

arr = [['stars', 'river'], 'letter', ['leaves', ['horses', 'table']]]

def add_string(array, flat_arr = [])
  array.each do |element|
    if element.class == String then flat_arr << element
    else add_string(element, flat_arr)
    end
  end
  flat_arr
end

p add_string(arr)