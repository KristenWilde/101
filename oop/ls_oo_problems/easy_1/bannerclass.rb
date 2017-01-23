# 1. Banner class

# class Message
#   def initialize
#   end
  
#   def 
#   end
# end


class Banner
  def initialize(message, given_width = nil)
    validate(given_width) if given_width
    width = given_width || message.size + EDGE_ALLOWANCE
    @message_array = if too_long?(message, width)
                       wrap(message, width)
                     elsif too_long?(message, MAX_WIDTH)
                       wrap(message, MAX_WIDTH)
                     else [message]
                     end
    @line_width = given_width || calculate_line_width
  end

  def to_s
    [horizontal_rule, empty_line, message_lines, empty_line, horizontal_rule].join("\n")
  end

  private

  attr_reader :line_width, :message_array
  MAX_WIDTH = 80
  EDGE_ALLOWANCE = 4
  
  def validate(given_width)
    if given_width < 0 || given_width > MAX_WIDTH
      puts "Error: width must be between 0 and 80."
    end
  end

  def too_long?(message, width)
    message.size > width - EDGE_ALLOWANCE
  end

  def wrap(message, width)
    wrap_width = width - EDGE_ALLOWANCE
    words = message.split(' ')
    lines = []
    loop do
      line = ''
      until line.length + words.first.length > wrap_width
        line << words.shift + ' '
        break if words.empty?
      end
      lines.push(line.chop) 
      break if words.empty?
    end
    lines
  end  # returns [first line, second line, etc.]

  def calculate_line_width
    longest_line = message_array.max_by { |line| line.size }
    longest_line.size 
  end

  def horizontal_rule
    "+-#{"-" * (line_width)}-+"
  end

  def empty_line
    "| #{' ' * (line_width)} |"
  end

  def message_lines
    message_array.map! do |line|
      "| #{line.center(line_width)} |"
    end    
    message_array.join("\n")
  end
end


puts Banner.new('To boldly go where no one has gone before.', 60)
puts Banner.new('To boldly go where no one has gone before.', 30)
puts Banner.new("Further exploration solution: message wraps if it is longer than the optional given width or if the banner would be wider than 80 px. Banner#wrap(message) doesn't break lines in the middle of a word.")
puts Banner.new("Further exploration solution: message wraps if it is longer than the optional given width or if the banner would be wider than 80 px. Banner#wrap(message) doesn't break lines in the middle of a word.", 80) 
puts Banner.new("Further exploration solution: message wraps if it is longer than the optional given width or if the banner would be wider than 80 px. Banner#wrap(message) doesn't break lines in the middle of a word.", 50)
puts Banner.new('', 22)

