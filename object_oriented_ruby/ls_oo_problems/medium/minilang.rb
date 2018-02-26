class MinilangRuntimeError < RuntimeError; end
class BadTokenError < MinilangRuntimeError; end
class EmptyStackError < MinilangRuntimeError; end

class Minilang
  def initialize(command_string)
    @commands = command_string.split
    @register = 0
    @stack = []
  end
  
  def eval
    @commands.each do |token|
      case token
      when integer(token) then @register = token.to_i
      when 'ADD' then add
      when 'SUB' then subtract
      when 'MULT' then mult
      when 'DIV' then div
      when 'MOD' then mod
      when 'POP' then pop
      when 'PUSH' then push
      when 'PRINT' then print_register
      else invalid_token(token)
      end
    end
    rescue MinilangRuntimeError => error
      puts error.message
  end
  
  private
  
  def integer(token)
    token.to_i.to_s
  end
  
  def invalid_token(token)
    raise BadTokenError, "Invalid token: #{token}"
  end
  
  def print_register
    puts @register
  end
  
  def add
    @register += @stack.pop
  end
  
  def subtract
    @register -= @stack.pop
  end
  
  def mult
    @register *= @stack.pop
  end
  
  def div
    @register /= @stack.pop
  end
  
  def mod
    @register %= @stack.pop
  end
  
  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end
  
  def push
    @stack.push(@register)
  end
  
  def print_register
    puts @register
  end
  
end

Minilang.new('PRINT').eval

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval