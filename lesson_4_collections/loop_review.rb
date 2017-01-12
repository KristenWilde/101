# count = 1

# loop do
#   if count.even?
#     puts "#{count} is even"
#   else puts count.to_s + " is odd"
#   end
#   count += 1
#   break if count > 5
# end

# loop do
#   number = rand(100)
#   puts number
#   break if (0..10).to_a.include?(number)
# end

# process_the_loop = [true, false].sample

# if process_the_loop
#   loop do
#     puts "The loop was processed!"
#     break
#   end
# else
#   puts "The loop wasn't processed!"
# end
  
# 5.times do |index|
#   puts index
#   break if index == 2
# end

# number = 0

# until number == 10
#   number += 1
#   puts number if number.even?
# end

# #

# number_a = 0
# number_b = 0

# loop do
#   number_a += rand(2)
#   number_b += rand(2)

#   if number_a == 5 || number_b == 5
#     puts "5 was reached!"
#     break
#   end
# end

# puts number_a
# puts number_b

# def greeting
#   puts 'Hello!'
# end

# number_of_greetings = 2
# counter = 0

# while counter < number_of_greetings
#   greeting
#   counter += 1
# end

# # def select_fruit(hash)
# #   counter = 0
# #   selected = {}
# #   loop do
# #     current_key = hash.keys[counter]
# #     if hash[current_key] == "Fruit"
# #       selected[current_key] = "Fruit"
# #     end
# #     counter += 1
# #     break if counter == hash.size
# #   end
# #   selected
# # end

# # produce = {
# #   'apple' => 'Fruit',
# #   'carrot' => 'Vegetable',
# #   'pear' => 'Fruit',
# #   'broccoli' => 'Vegetable'
# # }

# # p select_fruit(produce)

# h = { 1 => "a", 2 => "b", 3 => "c" }
# p h.shift   #=> [1, "a"]
# p h         #=> {2=>"b", 3=>"c"}
# p h.shift
# p h.shift
# p h.shift

# arr = ['10', '11', '9', '7', '8']

# p arr.sort { |x,y| y.to_i <=> x.to_i }

# new_hash = {}
# p ['ant', 'bear', 'cat'].inject(1) do |num, word| 
#   num + 1
# end

# p new_hash

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysees', author: 'James Joyce', published: '1922'}
]

p books.sort_by { |book| book[:published] }

