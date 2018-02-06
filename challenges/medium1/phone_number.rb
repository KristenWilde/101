=begin 
input: a user-entered phone number
output: a cleaned 10-digit string of numbers
rules:
- Bad number if less than 10 digits or more than 11.
- 10 digits, good.
- 11 digits starting with 1, trim the 1 and use the last 10.
- 11 digits and first number is not 1, bad.
- For bad number return 0000000000
- remove all spaces, -().
- if it has any letters, invalid.


=end
class PhoneNumber
  attr_reader :number

  def initialize(input)
    @number = cleanse(input)
  end

  def area_code
    @number[0..2]
  end

  def to_s
    "(#{@number[0..2]}) #{@number[3..5]}-#{(@number[6..9])}"
  end

  private
  BAD_NUMBER = '0000000000'

  def cleanse(input)
    return BAD_NUMBER if input.match(/[a-z]/i)
    number = input.gsub(/\D/, '')
    @number = if number.length == 10
                number
              elsif number.length == 11
                number[0] == '1' ? number[1..10] : BAD_NUMBER
              else 
                BAD_NUMBER
              end
  end
end

