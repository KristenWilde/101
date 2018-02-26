require 'pry'

def sls(str1, str2)
  strings = [str1, str2]
  array = strings.sort_by {|string| string.length }
  array.push(array[0])
  array.join
end

# p sls("one", "second") # => "onesecondone"
# p sls("", "xyz") # => "xyz"

# Hold data to convert numbers to ordinals st, nd, etc. Based on last 1-2 digits.
# Conditionals

# 1900-1999 -> 1901-2000 so add one to the year.
#year = year + 1

#2000

# 1st 2nd 3rd 4th 5th 6th 7th 8th 9th 10th
# (11th 12th 13th) 14th 




def century(year)
  
  century = year / 100
  unless year % 100 == 0
    century += 1
  end
  
  century = century.to_s
  
  
  suffix = if century[-2..-1] == "11" then "th"
           elsif century[-2..-1] == "12" then "th" 
           elsif century[-2..-1] == "13" then "th"
           elsif century[-1] == "1" then "st"
           elsif century[-1] == "2" then "nd"
           elsif century[-1] == "3" then "rd"
         else "th"
  end
  
  century + suffix
end


# p century (2120)
# p century(2000) == '20th'
# p century(2001) == '21st'
# p century(1965) == '20th'
# p century(256) == '3rd'
# p century(5) == '1st'
# p century(10103) == '102nd'
# p century(1052) == '11th'
# p century(1127) == '12th'
# p century(11201) == '113th'

# Leap years

# conditional - divisible by 400, 100 & 4, just 4, 

def leap_year?(year)
  if year < 1752
    if year % 4 == 0 then true
    else false
    end
  elsif year % 400 == 0
    true
  elsif year % 4 == 0 && year % 100 == 0 
    false
  elsif year % 4 == 0
    true
  else false
  end
end

# p leap_year?(2016) == true
# p leap_year?(2015) == false
# p leap_year?(2100) == false
# p leap_year?(2400) == true
# p leap_year?(240000) == true
# p leap_year?(240001) == false
# p leap_year?(2000) == true
# p leap_year?(1900) == false
# p leap_year?(1752) == true
# p leap_year?(1700) == true
# p leap_year?(1) == false
# p leap_year?(100) == true
# p leap_year?(400) == true

def greetings(name_array, hash)
  full_name = name_array.join(" ")
  title_job = hash[:title] + " " + hash[:occupation]
  "Hello, #{full_name}! Nice to have a #{title_job} around."
end

p greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })


# |

def merge(arr1, arr2)
  arr1 | arr2
end

p merge([1, 3, 5], [3, 6, 9])

# Find out if a given number is a fibonacci number

# start fibonacci caculation until result >= given number. 
# If the result = given number then true, else false.

def fibonacci?(n)
  return true if n == 1 || n == 2
  first, second = [1, 1]
  last = 1
  until last >= n
    last = first + second
    first, second = second, last
  end
  
  last == n
end

p fibonacci?(5) #== true
p fibonacci?(6) #== false
p fibonacci?(1) #== true
p fibonacci?(34) #== true
p fibonacci?(3)
