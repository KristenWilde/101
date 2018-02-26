def step(start_val, end_val, step_val) #block
  val = start_val
  until val > end_val do
    yield(val)
    val += step_val
  end
  start_val
end

step(1, 10, 3) {|value| puts "value = #{value}" }

# Some possible return values:
# 1. Array of values returned by the block. Useful in some situations, awkward in others.
# 2. The start value. Always know what you're going to get. 
# 3. Nil. Probably never useful, could cause bugs.
