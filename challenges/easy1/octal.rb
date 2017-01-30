class Octal
  
  def initialize(num_string)
    @octal_digits = num_string.chars
  end
  
  def to_decimal
    return 0 unless valid?
    decimal_num = 0
    @octal_digits.map!(&:to_i)
    0.upto(@octal_digits.size - 1) do |power|
      decimal_num += (@octal_digits.pop * (8**power))
    end
    decimal_num
  end
  
  def valid?
    return false if @octal_digits.include?('9') 
    return false if @octal_digits.include?('8')
    sans_leading_0s = @octal_digits.drop_while {|digit| digit == '0' }.join
    sans_leading_0s.to_i.to_s == sans_leading_0s
  end
end
