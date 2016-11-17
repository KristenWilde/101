require 'pry'

# Finding the longest sentence in a text file

# file = File.read("text_file.txt")
# sentences = file.split(/\.|\?|!/)
# sentences.map! do |sentence|
#   word_count = sentence.split.size
#   [sentence, word_count]
# end

# longest = sentences.max_by { |_, word_count| word_count }

# puts "The longest sentence in this file has #{longest[1]} words. The sentence is:"
# puts longest[0]


# Spelling Blocks

# BLOCKS = %w(BO XK DQ CP NA GT RE FS JW HU VI LY ZM).freeze

# def block_word?(word)
#   used_blocks = ""
#   word.length.times do |index|
#     letter = word[index].upcase
#     return false if used_blocks.include?(letter)
#     block = BLOCKS.select { |blk| blk.include?(letter) }
#     used_blocks << block[0]
#   end
#   true
#   # binding.pry
# end

# puts block_word?('BATCH')
# puts block_word?('BUTCH')
# puts block_word?('jest')

# Lettercase Percentages

def letter_percentages(string)
  total_chars = string.size.to_f
  lower_percent = string.count('a-z') / total_chars * 100 
  upper_percent = string.count('A-Z') / total_chars * 100 
  neither_percent = string.count('^(a-zA-Z)') / total_chars * 100 

  {lowercase: lower_percent, uppercase: upper_percent, neither: neither_percent}
end

# puts letter_percentages('abCdef 123')
# puts letter_percentages('AbCd +Ef')
# puts letter_percentages('123')

# Matching Parentheses

# regex - can we get overlapping matches?
#  - match from beginning & end of string? 

# Starting from the outside, match pairs. With recursion.

# Hash structure: 
#  - ( becomes a new key with default nil value.
#  - ) becomes the value of an open key.
#  - At end, are all pairs matched?

def balanced?(text)
  string = text.clone
  loop do
    char = string.slice!(0)
    break true if char == nil
    if char == "("
      matched = string.sub!(")", '')
      break false if matched == nil
    elsif char == ")"
      break false
    end
  end
end

# triangle classification by side length

def triangle(side1, side2, side3)
  sorted = [side1, side2, side3].sort
  if sorted.include?(0) || sorted[0] + sorted[1] <= sorted[2]
    :invalid
  elsif sorted.count(sorted[0]) == 2 || sorted.count(sorted[1]) == 2
    :isosceles
  elsif sorted.count(sorted[0]) == 3
    :equilateral
  else :scalene
  end
end

# triangle classification by angles

def triangle(angle1, angle2, angle3)
  angles = [angle1, angle2, angle3].sort
  if angles.inject(:+) != 180 
    :invalid
  elsif angles.any? {|angle| angle <= 0 }
    :invalid
  elsif angles.last == 90
    :right
  elsif angles.last > 90
    :obtuse
  else :acute
  end
end

# Friday the 13ths

def friday_13th?(year)
  fridays = 0
  month = 1
  while month < 13
    day = Time.new(year, month, 13)
    fridays += 1 if day.friday?
    month += 1
  end
  fridays
end
    
# Featured numbers
# odd
# multiple of 7
# no repeating digits

def no_repeating_digits(number)
  string_num = number.to_s
  0.upto(string_num.length - 1) do |index|
    return false if string_num[0...index].include?(string_num[index])
  end
  true
end

# puts no_repeating_digits(3453)

def featured(integer)
  number = integer + 1
  loop do 
    if number.odd? && number % 7 == 0 && no_repeating_digits(number)
      break number
    end
    number += 1
    if number.to_s.length > 9
      puts "There is no possible number that fulfills those requirements."
      break
    end
  end
end

# puts featured(12)
# puts featured(20) == 21
# puts featured(21) == 35
# puts featured(997) == 1029
# puts featured(1029) == 1043
# puts featured(999_999) == 1_023_547
# puts featured(999_999_987) == 1_023_456_987

puts featured(9_999_999_999)