require 'pry'

# # Teddy

# age = rand(181) + 20

# puts "What's your name?"
# name = gets.chomp
# name = 'Teddy' if name == ''
# puts "#{name} is #{age} years old!"

# # How big is the room

# CONVERSION = 10.7639

# puts "Enter the length of the room in meters:"
# length_in_meters = gets.to_f

# puts "Enter the width of the room in meters:"
# width_in_meters = gets.to_f

# area_in_m = length_in_meters * width_in_meters
# area_in_ft = (area_in_m * CONVERSION).round(2)

# puts "The area of the room is #{area_in_m.round(2)} square meters (#{area_in_ft} " +
#     "square feet)."

# # Tip calculator

# puts "What is the bill?" 
# bill = gets.to_f

# puts "What is the tip percentage?"
# percentage = gets.to_f * 0.01

# tip = (bill * percentage).round(2)
# total = bill + tip

# puts "The tip is $#{format('%.2f', tip)}"
# puts "The total is $#{format('%.2f', total)}"

# # When will I Retire?

# system('clear') || system('cls')

# puts "What is your age?"
# curr_age = gets.to_i

# puts "At what age would you like to retire?"
# retire_age = gets.to_i

# work_years = retire_age - curr_age
# current_year = Time.now.year
# retire_year = current_year + work_years


# puts "It's #{current_year}. You will retire in #{retire_year}."
# puts "You have only #{work_years} years of work to go!"

# # Greeting a user

# puts "What is your name?"
# name = gets.chomp
# if name[-1] == '!'
#   puts "HELLO #{name.upcase.chop}. WHY ARE WE SCREAMING?"
# else
#   puts "Hello #{name}."
# end

# # Odd numbers

# (1..99).each { |num| puts num  if num.odd? }

# # Even numbers

# puts (1..99).select(&:even?)

# Sum or Product of Consecutive Integers

def valid_integer?(input)
  input == input.to_i.to_s && input != 0
end

def sum(num)
  (1..num).inject(:+)
end

def product(num)
  (1..num).inject(:*)
end

int = nil

loop do
  puts "Please enter an integer greater than 0."
  int = gets.chomp
  if valid_integer?(int)
    int = int.to_i
    break
  end
  "That is not an integer greater than 0."
end

binding.pry

loop do
  puts "Enter 's' to compute the sum, or 'p' to compute the product."
  operation = gets.chomp.downcase
  
  if operation == 's'
    puts "The sum of the integers between 1 and #{int} is #{sum(int)}."
    break
  elsif operation == 'p'
    puts "The product of the integers between 1 and #{int} is #{product(int)}."
    break
  end
    puts 'Oops. Unknown operation'
end







