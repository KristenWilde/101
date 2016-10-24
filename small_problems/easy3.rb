# # Searching

# ordinals = ['1st', '2nd', '3rd', '4th', '5th', 'last']
# num_array = []
# until ordinals.empty? do
#   puts "==> Enter the #{ordinals.shift} number:"
#   number = gets.to_i
#   num_array.push(number) unless num_array.size == 5
# end

# # Another way:

# ordinals = ['1st', '2nd', '3rd', '4th', '5th', 'last']
# num_array = []
# number = nil

# 6.times do |i|
#   puts "==> Enter the #{ordinals[i]} number:"
#   number = gets.to_i
#   num_array.push(number) unless num_array.size == 5
# end

# if num_array.include?(number)
#   puts "The number #{number} appears in #{num_array.inspect}"
# else
#   puts "The number #{number} does not appear in #{num_array.inspect}"
# end  

# # Argument to a power

# def multiply(num1, num2)
#   num1 * num2
# end

# def power_to_n(num, power)
#   result = 1
#   power.times do 
#     multiply(result, num)
#   end
#   result
# end

# puts power_to_n(5, 3)

# # exclusive or

# def xor?(first, second)
#   first && !second || !first && second
# end

# # Odd lists. One way:

# def oddities(array)
#   new_array = []
#   array.each_with_index do |element, index|
#     new_array.push(element) if index.even?
#   end
#   new_array
# end

# # Another way:

# def oddities1(array)
#   new_array = []
#   array.each_with_index do |element, index|
#     new_array.push(element) if index.even?
#   end
#   new_array
# end

# # Could use delete_at, fetch, at, .map.with_index .select, delete_if, collect

# def oddities2(array)
#   array.map.with_index {|item, index| item unless index.even? }
#   .compact
# end

# def oddities3(array)
#   odd_index = 0
#   odd_array = []
#   while odd_index <= array.length
#     odd_array << array[odd_index]
#     odd_index += 2
#   end
#   odd_array
# end

# Palindromic Strings
#chop in center, reverse second half, chop last char if lengths not the same, compare
#problem: how long 

def palindrome?(string)
  first_half = string.slice(0, (string.length / 2))
  last_half = string.slice(-(string.length / 2), (string.length / 2))
  first_half == last_half.reverse
end

def real_palindrome?(string)
  bad_chars = string.delete(/W/.to_s)
  alphanumerics_only = string.downcase.delete(bad_chars)
  palindrome?(alphanumerics_only)
end

puts real_palindrome?('madam') == true
puts real_palindrome?('Madam') == true           # (case does not matter)
puts real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
puts real_palindrome?('356653') == true
puts real_palindrome?('356a653') == true
puts real_palindrome?('123ab321') == false