
class Anagram
  def initialize(match_word)
    @match_word = match_word
  end

  def match(word_array)
    word_array.select do |word|
      word.downcase.chars.sort == @match_word.downcase.chars.sort && word.downcase != @match_word.downcase
    end
  end
end

=begin
match method:
i: array of words
o: new array of words which have the same letters as @word.

@word = master
array = stream, pigeon, maters

a: look at each word
sort the letters
compare with sorted letters of original word.

=end
