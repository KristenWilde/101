require 'pry'

def check_and_fix_verbs_array(verbs_array)
  verbs_array.each_with_index do |verb, index|
    next if verb[-2..-1] == 'ed'
    loop do
      puts "Please enter another verb that ends with 'ed'."
      verb.replace(gets.chomp)
      break if verb[-2..-1] == 'ed'
    end
  end
  verbs_array
end

def check_and_fix_length(array, length_needed, word_type)
  while array.length < length_needed 
    puts "Please enter another #{word_type}."
    another = gets.chomp
    array.push(another)
  end
  array
end

system 'clear'

puts <<'TITLE'
   _____               .___.__   .__ ___.            
  /     \  _____     __| _/|  |  |__|\_ |__    ______
 /  \ /  \ \__  \   / __ | |  |  |  | | __ \  /  ___/
/    Y    \ / __ \_/ /_/ | |  |__|  | | \_\ \ \___ \ 
\____|__  /(____  /\____ | |____/|__| |___  //____  >
        \/      \/      \/                \/      \/ 
TITLE

puts "Let's make up a story!" 
puts "Please enter the name for our main character."
name = gets.chomp.capitalize

puts "Thanks. Is #{name} a 'she' or 'he'?"
pronoun = nil
loop do
  pronoun = gets.chomp
  if pronoun == 'she' || pronoun == 'he' then break
  else puts "Please enter 'she' or 'he'."
  end
end

puts "Now we need an exclamation - something you can shout."
exclamation = gets.chomp

puts "Good. Now we need some verbs."

verb_ing = nil
loop do
  puts "Please enter a verb that ends with 'ing'."
  verb_ing = gets.chomp
  break if verb_ing[-3..-1] == 'ing'
end

puts "Please type four verbs that end with 'ed', separated by spaces."
verbs_ed = gets.chomp.split
check_and_fix_length(verbs_ed, 4, "verb ending with 'ed'")
check_and_fix_verbs_array(verbs_ed)
verb_ed1, verb_ed2, verb_ed3, verb_ed4 = verbs_ed

puts "Please enter four adjectives."
adjs = gets.chomp.split
check_and_fix_length(adjs, 4, "adjective")
adj1, adj2, adj3, adj4 = adjs

puts "Please enter three animals."
animals = gets.chomp.split
check_and_fix_length(animals, 3, "animal")
animal1, animal2, animal3 = animals

puts "Please enter one adverb."
adverb = gets.chomp

puts "Please enter two colors."
colors = gets.chomp.split
check_and_fix_length(colors, 2, 'color')
color1, color2 = colors

puts "Please enter a substance."
substance = gets.chomp

puts "Please enter something that has a smell."
smell = gets.chomp

puts "Almost done! Enter a body part."
body_part1 = gets.chomp

puts "And another body part."
body_part2 = gets.chomp

puts "And a body of water (river etc.)."
body_of_water = gets.chomp

puts "And something in nature (forest etc.)"
nature = gets.chomp

puts "And one last noun. Then you get your story!"
noun = gets.chomp

system 'clear'

puts <<-STORY
Once upon a time, on a bright #{adj4} day, while #{name} was out #{verb_ing}, 
#{pronoun} looked out over the #{nature}. There in the distance was something 
small, furry, and #{color1}. 

'#{exclamation.capitalize}!! That must be my baby #{animal1},' thought #{name}. 
#{name} rushed over to pick up the little #{color1} thing, when suddenly it 
shot out a #{adj1} spray that smelled like #{smell}. 

'#{exclamation.upcase}, that was not my #{animal1}!' cried #{name}. 
#{pronoun.capitalize} #{verb_ed1} right into a nearby puddle of #{substance} to 
try to get the #{smell} smell off, but instead #{pronoun} just got covered with 
#{substance}. There was a #{body_of_water} nearby, so #{name} jumped right in - 
but it was much too #{adj2}. #{adj2.capitalize}, wet, and smelling strongly of 
#{smell}, #{name} #{verb_ed2} #{adverb} toward home as dark #{color2} clouds 
gathered above. 

'I don't know how I'm ever going to get this #{smell} off', #{pronoun} thought.
Just then #{pronoun} felt a big #{adj3} drop of rain on the #{body_part1}. 'And
now it's raining #{animal2}s and #{animal3}s!' #{name} #{verb_ed3} through 
the downpour as quickly as #{pronoun} could, but was soaked to the 
#{body_part2} when #{pronoun} arrived at home. 

'Can I go in the house all #{adj2}, covered with #{substance}, and smelling 
like #{smell}?' wondered #{name}. #{pronoun.capitalize} looked down and gave a 
sniff.

'#{exclamation.capitalize}! The rain has #{verb_ed4} me clean!!' #{name} went 
into the house, and there was #{name}'s little #{animal1} waiting for a hug.

THE #{noun.upcase}.
STORY