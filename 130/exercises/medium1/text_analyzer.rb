class TextAnalyzer
  def process
    File.open("text_file.txt") do |text|
      yield(text.read)
    end
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |file| puts "#{file.split("\n").size} lines" }
analyzer.process { |file| puts "#{file.split("\n\n").size} paragraphs" }
analyzer.process { |file| puts "#{file.split(" ").size} words" }

# Idea for trying regex for capturing words in a MatchData: (/(\b.+\b)/).captures.count