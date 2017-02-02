
# 1. Ben is right. Without a @, it calls the getter method for balance, which 
#    returns the variable, which can then be compared.

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

mine = BankAccount.new(-350)
puts mine.positive_balance?

# 2. There is a reader for quantity but not writer.

class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end  # self is required for writer methods.
end

# 3. Adding attr_accessor could be a problem, as it allows public access to the 
#    .quantity method. Better to use @quantity in the update_quantity method for 
#    that reason.

# 4. 

class Greeting
  def greet(msg)
    puts msg
  end
end

class Hello < Greeting
  def hi
    greet 'hello'
  end
end

class Goodbye < Greeting
  def bye
    greet 'Goodbye'
  end
end

s = Hello.new
s.hi
Goodbye.new.bye

# 5.

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type || "Plain"
    @glazing = glazing
  end
  
  def to_s
    string = @filling_type
    if @glazing then string << " with #{@glazing}"
    end
    string
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
#  => "Plain"

puts donut2
#  => "Vanilla"

puts donut3
#  => "Plain with sugar"

puts donut4
#  => "Plain with chocolate sprinkles"

puts donut5
#  => "Custard with icing"

# 6. #show_template works the same way in both classes, by using the attr_accessor.
#    #create_template writes to the variable directly in the first class, 
#    and in the second class uses the attr_accessor setter method.

# 7. change `light_information` to just `information`. It will be called on 
#    `Light` and `Light.light_information` is repetetive.

