def divisors(integer)
  divisors = []
  1.upto(integer) do |num|
    divisors << num if integer % num == 0
  end
  divisors
end

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]