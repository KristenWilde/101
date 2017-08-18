require 'pry'

class Palindromes
  attr_reader :largest, :smallest

  def initialize(params)
    @max_factor = params[:max_factor]
    @min_factor = params[:min_factor] || 1
  end

  def generate
    all_numbers = (@min_factor..@max_factor).to_a
    all_combinations = all_numbers.combination(2).to_a
    all_numbers.each {|num| all_combinations << [num, num]}
    all_combinations.each do |pair|
      product = pair[0] * pair[1]
      next unless is_palindrome(product)
      save_smallest(product, pair)
      save_largest(product, pair)
    end
  end

  private

  def save_smallest(product, factors)
    if @smallest == nil
      @smallest = Palindrome.new(product, factors)
    elsif @smallest.value < product
      return
    elsif @smallest.value == product
      @smallest << factors
    else
      @smallest = Palindrome.new(product, factors)
    end
  end  

  def save_largest(product, factors)
    if @largest == nil
      @largest = Palindrome.new(product, factors)
    elsif @largest.value > product
      return
    elsif @largest.value == product
      @largest << factors
    else
      @largest = Palindrome.new(product, factors)
    end
  end  

  def is_palindrome(num)
    num.to_s.reverse == num.to_s
  end

  def message
    puts "There are no palindromes in that range of numbers."
  end
end

class Palindrome
  attr_reader :value, :factors

  def initialize(value, factor_pair)
    @value = value
    @factors = [factor_pair]
  end

  def <<(factor_pair)
    @factors << factor_pair
  end
end

# palindromes = Palindromes.new(max_factor: 99, min_factor: 10)
# palindromes.generate
# p palindromes.largest.value
