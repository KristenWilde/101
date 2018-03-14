# https://www.codewars.com/kata/highest-scoring-word

def high(x)
 score = 0;
 words = x.split(' ')
 words_scores = words.map do |word|
   [word, score(word)]
 end
 max_score = words_scores.max_by do |word_arr|
   word_arr[1]
 end[1]

 i = 0
 word_score = nil
 result = nil
 loop do
   word_score = words_scores[i][1]
   word = words_scores[i][0]
   if word_score == max_score 
    return result = word
    break 
   end
   i += 1 
 end
 result
end

def score(word)
  word.codepoints.reduce(&:+)
end

p high('man i need a taxi up to ubud') # 'taxi'
p score('volcano')
p score('climbing')
# p high('what time are we climbing up the volcano') #, 'volcano')
# p high('take me to semynak') #, 'semynak')
# p high('aa b') #, 'aa'