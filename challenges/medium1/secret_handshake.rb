class SecretHandshake
  ACTIONS = ['wink', 'double blink', 'close your eyes', 'jump']

  def initialize(num)()
    @binary_string = num.to_i.to_s(2)
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