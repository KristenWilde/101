require 'pry'

class PalindromesTest 
  attr_accessor :max_factor, :min_factor

  def initialize(params)
    @max_factor = params[:max_factor]
    @min_factor = params[:min_factor] || 1
  end

  def generate_all
    @palindromes = {}
    all_numbers = min_factor.step(to: max_factor).to_a
    all_combinations = all_numbers.combination(2).to_a
    all_combinations.each do |pair|
      product = pair[0] * pair[1]
      if is_palindrome(product)
        if @palindromes[product]
          then @palindromes[product] << pair 
          else @palindromes[product] = [pair]
          end
      end
    end
    @palindromes
  end

  def generate
    i = 1
    @smallest = nil
    until @smallest do
      find_palindromes_and_factors(@min_factor, @min_factor+i)
      i += 1
    end

    @largest = nil
    i = 1
    until @largest do
      find_palindromes_and_factors(@max_factor-i, @max_factor)
      i += 1
    end
  end

  def find_palindromes_and_factors(min, max)
    number_set = (min..max).to_a
    combinations = number_set.combination(2).to_a
    number_set.each {|num| combinations << [num, num]} # putting doubles in the array
    results = {}
    combinations.each do |pair|
      product = pair[0] * pair[1]
      next unless is_palindrome(product)
      case (results[value] <=> product)
      when 1 # stored value is greater
        next
      when 0 # they're equal
        results[factors] << pair
      when -1 # product is greater
        results[factors] = [pair]
        results[value] = product
      end
    end
    results
  end


  def largest
    @largest
  end

  def smallest
    @smallest
  end

  def value

  end

  def factors

  end

  def is_palindrome(num)
    return_val = (num.to_s.reverse == num.to_s)
    p return_val
    return_val
  end
end

my_test = PalindromesTest.new(max_factor: 9)
my_test.generate
p my_test.smallest
