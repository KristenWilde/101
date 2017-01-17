def times(num)
  counter = 0
  loop do
    yield(counter)
    counter += 1
    break if counter == num
  end
  num
end

times(5) { |number| puts number }

# How to write this with an explicit block parameter? Not sure, the following doesn't work.

# def times(&block num)
#   counter = 0
#   loop do
#     block.call(counter)
#     counter += 1
#     break if counter == num
#   end
#   num
# end

# times(5) { |number| puts number }

def each(array)
  counter = 0
  while counter < array.size
    yield(array[counter])
    counter += 1
  end
  array
end

def select(array)
  counter = 0
  selected_array = []
  while counter < array.size
    selected_array << array[counter] if yield(array[counter])
    counter += 1
  end
  selected_array
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? } 

def reduce(array, accumulator = 0)
  counter = 0
  while counter < array.size
    accumulator = yield(accumulator, array[counter])
    counter += 1
  end
  accumulator
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
p reduce(array) { |acc, num| acc + num if num.odd? } 