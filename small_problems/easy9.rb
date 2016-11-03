def greetings(name_array, hash)
  name = name_array.join(' ')
  title = hash[:title] + ' ' + hash[:occupation]
  greeting = "Hello, #{name}! Nice to have a #{title} around."
  puts greeting
end

# greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })

# def twice(num)
#   num_string = num.to_s
#   check_array = []
#   num_string.length.times do |index1|
#     num_string[index1] = char_to_match
#     num_string.index(char_to_match, index1 + 1) = index2
#     check_array.push([index1, index2])
#   end
#   # abandoning this attempt
# end

def twice(num)
  midpoint, remainder = num.to_s.length.divmod(2)
  if remainder == 1
    num * 2
  else 
    if num.to_s[0, midpoint] == num.to_s[midpoint, midpoint]
      num
    else num * 2
    end
  end
end

