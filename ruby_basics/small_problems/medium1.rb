require 'pry'

def rotate_array(array)
  copy = array.clone
  copy.push(copy.shift)
end

def rotate_rightmost_digits(num, digits)
  digit_array = num.to_s.split('')
  digit_array[-digits, digits] = rotate_array(digit_array[-digits, digits])
  digit_array.join("").to_i
end

def max_rotation(num)
  places = num.to_s.length
  places.downto(2) { |digits| num = rotate_rightmost_digits(num, digits) }
  num
end

# 1000 lights program

NUMBER_OF_LIGHTS = 1000
TIMES_TO_TOGGLE = 1000

lights = Array.new(NUMBER_OF_LIGHTS, false)

1.upto(TIMES_TO_TOGGLE) do |round|
  lights.map!.with_index do |value, index| 
    ((index + 1) % round).zero? ? !value : value
  end
end

lights_on = []
lights.each_with_index do |value, index| 
  lights_on << (index + 1).to_s if value == true 
end
lights_on[-1].prepend("and ")

puts "With #{NUMBER_OF_LIGHTS} lights, #{lights_on.size} lights are left on: " +
     "lights #{lights_on.join(', ')}."

def diamond(grid_size)
  lines = Array.new(1, "*" * num)
  (grid_size - 2).step(by: -2).take(grid_size / 2).each do |stars|
    lines << ("*" * stars).center(grid_size)
    lines.insert(0, ("*" * stars).center(grid_size))
  end
  puts lines
end

# Based on ideas from Ryann and Lee:

def hollow_diamond(int)
  spaces = 1
  puts '*'.center(int)
  
  1.upto(int - 4) do |line|
    puts ('*' + ' ' * spaces + '*').center(int)
    line > (int / 2 - 2) ? spaces -= 2 : spaces += 2
  end
  
  puts '*'.center(int)
end

####

DIGITS = {'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3',
         'four' => '4', 'five' => '5', 'six' => '6', 'seven' => '7',
         'eight' => '8', 'nine' => '9' }

def word_to_digit(sentence, format = 'phone')
  DIGITS.each do |word, numeral|
    sentence.gsub!(/\b#{word}\b/i, numeral)
  end

  sentence.gsub!(/(\d)\s/, '\1')   # Removes spaces

  if format == 'phone'
    phone_seven = /(\d{3})(\d{4})/
    phone_ten = /(\d{3})(\d{3})(\d{4})/
    
    sentence.gsub!(phone_ten, '(\1) \2-\3') ||
    sentence.gsub!(phone_seven, '\1-\2')
  
  else
    sentence
  end
end

puts word_to_digit('Please call me at five five five one two three four. Thanks.')

puts word_to_digit('three Three seven four one two five five one two.')

####

def fibonacci(nth)
  first, last = [1, 1]
  3.upto(nth) do
    first, last = [last, first + last]
  end

  last
end

def fibonacci_last(nth)
  fibonacci(nth).to_s[-1]
end

puts fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
puts fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
puts fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
puts fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
puts fibonacci_last(123456789)