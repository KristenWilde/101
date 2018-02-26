def max_by(arr) #block
  return nil if arr.empty?
  
  arr.inject([yield(arr[0]), arr[0]]) do |max, item|
    yield(item) > max[0] ? [yield(item), item] : max
  end
  .at(1)
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil