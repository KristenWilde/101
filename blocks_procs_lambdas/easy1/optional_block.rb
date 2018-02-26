def compute(a)
  return "Does not compute" unless block_given?
  yield(a)
end

puts compute(5) { |n| n**2 } # => 25

puts compute("c") { |letter| letter + "at" } # =>"cat"

puts compute(500) # =>"Does not compute"