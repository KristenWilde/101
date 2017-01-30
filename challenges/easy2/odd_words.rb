# Plan:
# Set up class and methods
# split to array
#   - remove point
#   - split words
# Use conditional for index -- if (index + 1).odd? 
#  reverse.
# Join words
# Add point.


class OddWords
  def initialize(string)
    @original = string
  end
  
  def reverse_odds
    word_array = @original.chop.split
    reversed = word_array.map.with_index do |word, index|
      if index.odd? then word.reverse!
      else word
      end
    end
    reversed.join(" ") + "."
  end
end

test = OddWords.new("whats the matter with kansas.")

p test.reverse_odds
