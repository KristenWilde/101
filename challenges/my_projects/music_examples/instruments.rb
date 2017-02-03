module Twinkle
  attr_accessor :words, :melody
  @melody =
    [
    "#{" " * (5) * 4}4 5",
    "#{" " * (@syllable_size + 1) * 2}2 3 #{" " * (@syllable_size + 1) * 2}6",
    "",
    "",
    "0 1"
    ]
    
  @words = "Twin-kle twin-kle lit-tle star"
  
  @syllable_size = 4
  
end

class Voice
  include Twinkle
  def initialize
    @sound = "la"
  end
  
  def syllable_size
    @syllable_size = @sound.size
  end
  
  def sing(song=Twinkle)
    word_arr = song.words.scan(/.[^- ]+/)
    
    song.melody.each_with_index do |line, idx|
      puts "line: #{line}"
    end
  end
end

class Musician

  attr_accessor :sound
  
  
  def initialize
  end
  
  
  def play
    
  end
end

class Violin
  def initialize
    @sound = "zum"
  end
  
  def play(melody)
    
  end
end

taylor = Voice.new

taylor.sing





  # def twinkle(sound)
  #   space = " " * (sound.length + 1)

  #   puts "#{space * 4}#{sound} #{sound}"
  #   puts "#{space * 2}#{sound} #{sound} #{space * 2}#{sound}#{sound[-1] * 3}"
  #   puts
  #   puts
  #   puts "#{sound} #{sound}"
  # end

