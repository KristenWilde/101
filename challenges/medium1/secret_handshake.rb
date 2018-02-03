=begin
'commands' takes a base-10 number, and returns an array of strings.
rules:
- Accept valid 
- Convert base-10 number to binary.
- Don't need to go above 31/11111
- 

=end
class SecretHandshake
  ACTIONS = ['wink', 'double blink', 'close your eyes', 'jump']

  def initialize(num)
    @binary_string = format('%05b', num.to_i)
    # returns a string of 1's and 0's with length 5.
  end

  def commands
    result = []

    @binary_string.chars.reverse.each_with_index do |char, idx|
      if char == '1'
        idx == 4 ? result.reverse! : result.push(ACTIONS[idx])
      end
    end

    result
  end
end