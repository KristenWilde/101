
class OCR
  KEY= [" _\n| |\n|_|\n", 
        "\n  |\n  |\n", 
        " _\n _|\n|_\n", 
        " _\n _|\n _|\n",
        "\n|_|\n  |\n", 
        " _\n|_\n _|\n", 
        " _\n|_\n|_|\n", 
        " _\n  |\n  |\n",
        " _\n|_|\n|_|\n", 
        " _\n|_|\n _|\n" ]
  
  def initialize(text)
    @text = text
  end
  
  def convert
    @text.split("\n\n").map {|row| convert_row(row) }.join(",")
  end
  
  def convert_digit(num_string)
    if KEY.include?(num_string) then KEY.index(num_string).to_s 
    else "?"
    end
  end
  
  def convert_row(row)
    number_of_digits = row.gsub("\n", "").size / 9
    number_of_digits += 1 unless row.gsub("\n", "").size % 9 == 0 
    individual_numbers = Array.new(number_of_digits, "")
    row.split("\n").each do |line|
      number_of_digits.times do |i| 
        individual_numbers[i] += line[(i * 3), 3].rstrip + "\n"
      end
    end
    result = ""
    individual_numbers.each do |num_string|
      result += convert_digit(num_string)
    end
    result
  end
end
