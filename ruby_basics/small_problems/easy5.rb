def ascii_value(string)
  sum = 0
  string.each_char {|char|  sum += char.ord }
  sum
end

MIN_PER_HOUR = 60
HOURS_PER_DAY = 24

def time_of_day(minutes_after_midnight)
  hours, minutes = minutes_after_midnight.abs.divmod(60)
  hours = hours % 24
  unless minutes_after_midnight.positive? || minutes_after_midnight.zero?
    hours = 24 - hours
    minutes = 60 - minutes
    hours -= 1 if minutes > 0
  end
  format("%02d", hours) + ":" + format("%02d", minutes)
end

# Letter swap

# Works except for one-letter words
def swap(sentence)
  sentence.split.map do |word|
    if word.size >= 2
      first = word.slice!(0)
      last = word.slice!(-1)
      last + word + first
    else word
    end
  end
  sentence.join(' ')
end

def swap(sentence)
  sentence.split.map do |word|
    word.split (/^w.?w$?/) 
  end
end

###

def cleanup(string)
  string.gsub(/[^a-z]+/i, ' ')
end

ALPHABETIC = ('A'..'z')

def cleanup(string)
  string.chars.map { |char| ALPHABETIC.include?(char) ? char : ' ' }
  .join.squeeze(' ')
end

###

def word_sizes(sentence)
  counts = Hash.new(0)
  sentence.split.each do |word|
    size = word.gsub(/[^a-z]+/i, '').size
    counts[size] += 1
  end
  counts
end

###

NUMBER_WORDS = %w(zero one two three four five six seven eight nine ten
                  eleven twelve thirteen fourteen fifteen sixteen seventeen 
                  eighteen nineteen)

NUMBERS_TO_WORDS = NUMBER_WORDS.map.with_index do |word, index|
                    Array.new[0, 1] = index, word
                  end.to_h

def alphabetic_number_sort(num_array) 
  num_array.map { |num| NUMBERS_TO_WORDS[num] }
  .sort.map { |word| NUMBERS_TO_WORDS.key(word) }
end

def alphabetic_number_sort(num_array)
  num_array.sort_by { |number| NUMBER_WORDS[number] }
end

###

def crunch(string)
  string.squeeze
end

###

MAX_WIDTH = 76

def wrap(message)
  words = message.split
  lines = []
  loop do
    new_line = ''
    until new_line.length + words[0].length > MAX_WIDTH
      new_line << words.shift + ' '
      break if words.empty?
    end
    lines.push(new_line) 
    break if words.empty?
  end
  lines
end  # returns [line1, line2, line3 . . . ]

def print_in_box(message)
  message_lines = wrap(message)
  width = message_lines.max_by { |x| x.length }.length
  
  horizontal_rule = '+-' + '-'*width + '-+'
  empty_line =  '| ' + ' '*width + ' |'
  
  puts horizontal_rule
  puts empty_line

  message_lines.each do |line|
    puts '| ' + line.center(width, ' ') + ' |'
  end

  puts empty_line
  puts horizontal_rule
end