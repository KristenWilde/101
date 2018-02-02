class PerfectNumber
  def self.classify(num)
    raise RuntimeError if num < 1 

    case self.Aliquot_sum(num) <=> num
    when 0 then 'perfect'
    when -1 then 'deficient'
    when 1 then 'abundant'
    end
  end

  def self.Aliquot_sum(num)
    factors = [1]
    counter = 2
    multiplier = nil
    loop do
      multiplier = num.to_f / counter
      break if multiplier < counter
      factors.push(counter, multiplier.to_i) if multiplier == multiplier.floor
      counter += 1
    end
    factors.reduce(&:+)
  end

end

p PerfectNumber.classify(-1) #abundant
# p PerfectNumber.classify(20) #deficient
# p PerfectNumber.Aliquot_sum(6) # 6
# p PerfectNumber.Aliquot_sum(28) # 28
# p PerfectNumber.Aliquot_sum(7) #1

=begin
input number, output 'perfect', 'deficient', or 'abundant'
perfect: sum of factors equals the number
deficient: sum of factors is less than the num
abundant: sum of factors is greater than the num
prime numbers are deficient.

approach: 
- get factors
  - factors = []
  - Set counter = 1
  - initialize multiplier
  Loop:
    - set multiplier = num.to_f / counter
    - break if multiplier > counter
    - if multiplier is whole number,
      - factors.push counter, multiplier
    - increment counter

- get sum of factors

v compare 

  
=end