class FixedArray
  def initialize(size)
    @size = size             # storing this for use later
    @array = Array.new(@size)
  end
  
  def to_s
    @array.to_s
  end
  
  def []=(index, obj)
    raise IndexError unless ((-@size - 1)..@size).include?(index)
    @array[index] = obj
  end
  
  def [](index)
    raise IndexError unless ((-@size - 1)..@size).include?(index)
    @array[index]
  end
  
  def to_a
    @array.clone
  end
end


fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

puts fixed_array.to_s
