ONES = [ '', 'one ', 'two ', 'three ', 'four ', 'five ', 'six ', 'seven ',
         'eight ', 'nine ']
TENS = ['', 'ten ', 'twenty ', 'thirty ', 'forty ', 'fifty ', 'sixty ',
        'seventy ', 'eighty ', 'ninety '] 
TEENS = ['', 'eleven ', 'twelve ', 'thirteen ', 'fourteen ', 'fifteen ', 
         'sixteen ', 'seventeen ', 'eighteen ', 'nineteen ']
ILLIONS = [[15, "quadrillion "], [12, "trillion "], [9, "billion "],
          [6, "million "], [3, "thousand "], [0, '']] 

def integer_to_words(number)
  if number == 0
    return 'zero'
  end

  num_string = ''

  ILLIONS.each do |power, illion|
    this_illion, number = number.divmod(10**power)
    next if this_illion == 0

    hundreds = this_illion / 100
    
    if hundreds > 0
      num_string << ONES[hundreds] + 'hundred ' 
    end  

    tens = this_illion % 100 / 10
    ones = this_illion % 10
    
    if tens == 1 && ones > 0
      num_string << TEENS[ones]
    else
      num_string << TENS[tens]
      num_string << ONES[ones]    
    end
  
    num_string << illion
  end

  num_string.chop
end

puts 'Please enter some digits.'
loop do
  number = gets.chomp
  break if (number == "q") || (number == "Q")
  number = number.to_i
  puts integer_to_words(number)
  puts 'Enter another number if you want! Or Q to quit.'
end