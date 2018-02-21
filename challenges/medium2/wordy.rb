# input: WordProblem.new(question string).answer
# output: integer
# rules:
# question string matches this pattern:
# '\AWhat is (-*\d+) (plus|minus|multiplied by|times|divided by) (-*\d+)' +
#  '(?:(plus|minus|multiplied by|times|divided by) (-*\d+))*\?\Z'
 
# otherwise, there is an argument error

# Data structure: array of matches contained in instance variable 'matches'.

# Algorithm:
# 1. Initialize method initializes 'matches' or raises argument error.
# regex_string = '\AWhat is (-*\d+) ' + 
#         '(plus|minus|multiplied by|times|divided by) (-*\d+)' +
#         '(?: (plus|minus|multiplied by|times|divided by) (-*\d+))*\?\Z'
# regex = Regexp.new(regex_string, Regexp::IGNORECASE)
# Remove first value (shift) if it is not a number (matches[0].to_i.to_s != matches[0]).


# map even indexes to numbers, and odd indexes to operation strings.

# 2. answer method evaluates the problem.
# loop using index and send

class WordProblem
  def initialize(question)
    regex_string = '\AWhat is (-*\d+) ' + 
        '(plus|minus|multiplied by|times|divided by) (-*\d+)' +
        '(?: (plus|minus|multiplied by|times|divided by) (-*\d+))*\?\Z'
    pattern = Regexp.new(regex_string, Regexp::IGNORECASE)
    @components = question.match(pattern).to_a
    raise ArgumentError unless @components.length > 0

    @components.shift unless @components[0].to_i.to_s == @components[0]
    @components = @components.map.with_index do |component, idx|
      idx.even? ? component.to_i : convert_to_operator(component) 
    end
  end

  def answer
    i = 1
    result = @components[0]
    loop do
      result = result.send(@components[i], @components[i + 1])
      i += 2
      break unless @components[i]
    end
    result
  end

  def convert_to_operator(phrase)
    case phrase
    when 'plus' then '+'
    when 'minus' then '-'
    when 'multiplied by' || 'times' then '*'
    when 'divided by' then '/'
    end
  end

end

p WordProblem.new('What is 1 plus 1?').answer

