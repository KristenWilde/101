ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

under_100 = ages.select { |_, v| v < 100 }

p under_100

# .select when used on a hash returns a hash. This is because there is a 
# Hash#select method which returns a hash. Array#select and Enumerable#select 
# both return arrays.

