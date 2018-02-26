def interleave(arr1, arr2)
  arr1.zip(arr2).flatten
end

def letter_case_count(string)
  counts = {}
  counts[:lowercase] = string.count("a-z")
  counts[:uppercase] = string.count("A-Z")
  counts[:neither] = string.count("^A-Za-z")
  counts
end

def word_cap(string)
  string.split.map { |word| word.capitalize!}. join(' ')
end

def swapcase(string)
  string.chars.map do |char|
    if ('a'..'z').include? char
      char.upcase
    elsif ('A'..'Z').include? char
      char.downcase
    else
      char
    end
  end
  .join
end

def staggered_case(string, start_up = true)
  string.chars.map do |char|
    if char =~ /[^a-zA-Z]/
      char
    else
      start_up = !start_up
      if start_up
        char.downcase
      else char.upcase
      end
    end
  end
  .join
end

def multiplicative_average(integer_array)
  average = integer_array.inject(:*) / integer_array.size.to_f
  puts "The result is " + format("%.3f", average)
end

def multiply_list(arr1, arr2)
  arr1.zip(arr2).map { |arr| arr[0] * arr[1] }
end

def multiply_list(arr1, arr2)
 arr1.zip(arr2).map {|ar| ar.reduce(:*) }
end

def multiply_all_pairs(arr1, arr2)
  arr1.product(arr2).map {|ar| ar.reduce(:*) }.sort
end

def penultimate(string)
  string.split[-2]
end