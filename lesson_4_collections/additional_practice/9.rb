words = "the flintstones rock"

def titleize (string)
  string.split.map { |word| word.capitalize }.join(" ")
end

p titleize words