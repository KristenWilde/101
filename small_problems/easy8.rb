
def sum_of_sums(array)
  array.map.with_index { |_,index| array.take(index + 1).inject(:+) }.inject(:+)
end
    
def sum_of_sums(array)
  array.map.with_index { |num, i| num * (array.length - index) }.inject(:+)
end

def substrings_at_start(string)
  array = []
  1.upto(string.length) do |count|
    array.push(string[0, count + 1])
  end
  array
end

def substrings(string)
  0.upto(string.length).map do |index| 
    substrings_at_start(string[index..-1]) 
  end
  .flatten
end

def palindromes(string)
  substrings(string).select do |string| 
    string == string.reverse && string.length > 1 
  end
end

def fizzbuzz(start_num, end_num)
  start_num.upto(end_num) do |num|
    if num % 3 == 0 && num % 5 == 0
      print 'FizzBuzz' 
    elsif num % 3 == 0
      print "Fizz"
    elsif num % 5 == 0
      print 'Buzz' 
    else 
      print num
    end
    print ", " unless num == end_num
  end
  puts  # starts a new line and prevents a return value
end

def repeater(string)
  string.chars.map { |char| char * 2 }.join
end

def double_consonants(string)
  string.chars.map do |char| 
    char =~ /[a-z&&[^aeiuo]]/i ? char * 2 : char 
  end
  .join
end

def reversed_number(integer)
  integer.to_s.reverse.to_i
end

def center_of(string)
  half = string.length.to_f / 2
  if half == half.to_i
    string[half.to_i - 1, 2]
  else
    string[half.to_i]
  end
end