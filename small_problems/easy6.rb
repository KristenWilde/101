# MINUTES_IN_DEGREE = 60
# SECONDS_IN_MINUTE = 60

# def dms(angle)
#   degrees = angle.floor
#   minutes_floor = ((angle - degrees) * MINUTES_IN_DEGREE).floor
#   minutes = ((angle - degrees) * MINUTES_IN_DEGREE).round
#   seconds = (((angle - degrees) * MINUTES_IN_DEGREE - minutes_floor) * SECONDS_IN_MINUTE).round
#   "%(" + format("%d°%02d'%02d", degrees, minutes, seconds) + '")'
# end

# puts dms(30) 
# puts dms(76.73) 
# puts dms(254.6) 
# puts dms(93.034773) 
# puts dms(0) 
# puts dms(360)  

DEGREE = "\xC2\xB0"
MINUTES_PER_DEGREE = 60
SECONDS_PER_MINUTE = 60
SECONDS_PER_DEGREE = MINUTES_PER_DEGREE * SECONDS_PER_MINUTE

def dms(degrees_float)
  total_seconds = (degrees_float * SECONDS_PER_DEGREE).round
  degrees, remaining_seconds = total_seconds.divmod(SECONDS_PER_DEGREE)
  minutes, seconds = remaining_seconds.divmod(SECONDS_PER_MINUTE)
  [degrees, minutes, seconds]
  # format(%(#{degrees}#{DEGREE}%02d'%02d"), minutes, seconds)
end

puts dms(30) 
puts dms(76.73) 
puts dms(254.6) 
puts dms(93.034773) 
puts dms(0) 
puts dms(360)  

###

def remove_vowels(string_array)
  string_array.map { |string| string.delete("/[aeiouAEIOU]+/i") }
end

###

def fibonacci(index)
  num1 = 1
  num2, answer = 0
  index.times do
    answer = num1 + num2
    num1, num2 = num2, answer
  end
  answer
end

def find_fibonacci_index_by_length(digits)
  n = 1
  loop do
    break n if (fibonacci(n)).to_s.length == digits
    n += 1
  end
end

###

def reverse_array!(array)
  half = array.length / 2
  index = 0
  until index + 1 > half
    array[index], array[-index - 1] = array[-index - 1], array[index]
    index += 1
  end
  array
end

def reverse_array(array)
  new_array = array.clone
  array.length.times do |index|
    new_array.insert(index, new_array.pop)
  end
  new_array
end

def reverse_array(array)
  array.inject([]) do |new_array, element|
    new_array.unshift(element)
  end
end

def merge(arr1, arr2)
  arr1 | arr2
end

def halvsies(array)
  half = array.length / 2
  copy = array
  new_array = []
  new_array[1] = copy.slice!(-half, half)
  new_array[0] = copy
  new_array
end

def find_dup(array)
  array.each {|item| break item if array.count(item) > 1 }
end

def include?(array, value)
  !!array.find_index(value)
end

def triangle(n)
  1.upto(n) do |count|
    puts " " * (n - count) + "*" * count
  end
end
  
  