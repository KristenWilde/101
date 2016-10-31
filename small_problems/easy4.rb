# def short_long_short(string1, string2)
#   longer = string1.length >= string2.length ? string1 : string2
#   shorter = longer == string1 ? string2 : string1
#   shorter + longer + shorter
# end

# puts short_long_short('abc', 'defgh')

### What century?

# def century(year)
#   century = year / 100 
#   century += 1 unless year % 100 == 0
#   century.to_s + century_suffix(century)
# end

# def century_suffix(century)
#   return 'th' if [11, 12, 13].include?(century % 100)
#   last_digit = century % 10
  
#   case last_digit
#   when 1 then 'st'
#   when 2 then 'nd'
#   when 3 then 'rd'
#   else 'th'
#   end
# end

# puts century(2000) == '20th'
# puts century(2001) == '21st'
# puts century(1965) == '20th'
# puts century(256) == '3rd'
# puts century(5) == '1st'
# puts century(10103) == '102nd'

### Leap years

# def leap_year?(year)
#   if year >= 1752
#     year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
#   else
#     year % 4
#   end
# end

# puts leap_year?(2016) == true
# puts leap_year?(2015) == false
# puts leap_year?(2100) == false
# puts leap_year?(2400) == true
# puts leap_year?(240000) == true
# puts leap_year?(240001) == false
# puts leap_year?(2000) == true
# puts leap_year?(1900) == false
# puts leap_year?(1752) == true
# puts leap_year?(1700) == false
# puts leap_year?(1) == false
# puts leap_year?(100) == false
# puts leap_year?(400) == true

# # Multiples of 3 and 5

# def multisum(num)
#   multiples = []
#   (3..num).step(3) { |x| multiples.push(x) }
#   (5..num).step(5) { |x| multiples.push(x) }
#   multiples.inject(:+)
# end

# puts multisum(10)

### Running Total

# def running_total(array)
#   sum = 0
#   array.map { |num| sum += num }
# end

# puts running_total([2, 5, 13]) 
# puts running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
# puts running_total([3]) == [3]
# puts running_total([]) == []

# Converting string to a number
DIGITS = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
}

def string_to_integer(string)
  numbers = []
  for index in (1..string.length)
    number = DIGITS[string[-index]]
    numbers.push(number * 10**(index - 1))
  end
  numbers.inject(:+)
end

def digit_convert(digit)
  case digit
  when '1' then 1
  when '2' then 2
  when '3' then 3
  when '4' then 4
  when '5' then 5
  when '6' then 6
  when '7' then 7
  when '8' then 8
  when '9' then 9
  else 0
  end
end

def string_to_signed_integer(string)
  case string[0] 
  when '-' 
    string_to_integer(string.delete('-')) * -1
  when '+'
    string_to_integer(string.delete('+'))
  else 
    string_to_integer(string)
  end
end

### 

DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '-']

def signed_integer_to_string(number)
  result = ''
  unless number.positive?
    sign = :negative
    number *= -1
  end
    
  loop do
    number, remainder = number.divmod(10)
    result.prepend(DIGITS[remainder])
    break if number == 0
  end
  result.prepend('-') if sign == :negative
  result
end

def signed_integer_to_string(number)
  case number <=> 0
  when -1 then "-#{integer_to_string(-number)}"
  when +1 then "+#{integer_to_string(number)}"
  else         integer_to_string(number)
  end
end