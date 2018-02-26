# Easy 1

# Repeat Yourself

def repeat (string, pos_interger)
  pos_interger.times { puts string }
end

repeat('Hello', 3)

# Odd

def is_odd?(num)
  num % 2 == 1
end

# List of digits

def digit_list(interger)
  interger.to_s.chars.map(&:to_i)
end

# How many?

def count_occurrences(array)
  array.uniq.each { |item| puts "#{item} => #{array.count(item)}" }
end

vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck', 'motorcycle',
            'motorcycle', 'car', 'truck']

count_occurrences(vehicles)

# Reverse It

def reverse_sentence(sentence)
  sentence.split.reverse.join ' '
end

puts reverse_sentence('Reverse these words')

# Pt 2

def reverse_words(sentence)
  sentence.split.map do |word| 
    word.size >= 5 ? word.reverse : word 
  end  
  .join(' ')
end

puts reverse_words('Just practicing ruby.')

# Stringy Strings

def stringy(num, start = 1)
  new_string = ""
  
  num.times do |index| 
    if index.even? 
      new_string << start.to_s
    else 
      new_string << ((start - 1).abs.to_s)
    end
  end
  
  new_string
end

puts stringy(7, 0)

# Array Average

def average(num_array)
  num_array.reduce(:+).to_f / num_array.size
end

puts average([1, 5, 87, 45, 8, 8])

# Sum of Digits

def sum(num)
  num.to_s.chars.map(&:to_i).inject(:+)
end

puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45

# What's my bonus?

def calculate_bonus(salary, tf)
  tf ? salary / 2 : 0
end

puts calculate_bonus(2800, true)


    