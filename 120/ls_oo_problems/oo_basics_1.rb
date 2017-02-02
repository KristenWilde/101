# 1. find the class

puts 'Hello'.class
puts 5.class
puts [1, 2, 3].class

# 2. Create the class

class Cat; end

# 3. Create the object

class Cat; end
  
kitty = Cat.new

# 4. What Are You?

class Cat
  def initialize
    puts "I'm a cat!"
  end
end

kitty = Cat.new

# 5. Hello Sophie

class Cat
  def initialize(name)
    @name = name
    puts "Hello! My name is #{@name}"
  end
end
  
kitty = Cat.new('Sophie')

# 6. Hello Sophie 2

class Cat
  def initialize(name)
    @name = name
  end
  
  def greet
    puts "Hello! My name is #{@name}"
  end
end
  
kitty = Cat.new('Sophie')
kitty.greet

# 7. Reader

class Cat
  attr_reader :name                  # note placement before initialize. It works. Is this a convention?

  def initialize(name)
    @name = name
  end
  
  def greet
    puts "Hello! My name is #{name}"
  end
end
  
kitty = Cat.new('Sophie')
kitty.greet

# 8. Writer / 9. Accessor

class Cat
  attr_accessor :name                  # note placement before initialize. It works. Is this a convention?

  def initialize(name)
    @name = name
  end
  
  def greet
    puts "Hello! My name is #{name}"
  end
end
  
kitty = Cat.new('Sophie')
kitty.greet
kitty.name = "Luna"
kitty.greet

# 10. Walk the cat

module Walkable
  def walk
    puts "Let's go for a walk"
  end
end

class Cat
  include Walkable
  
  attr_accessor :name                  # note placement before initialize. It works. Is this a convention?

  def initialize(name)
    @name = name
  end
  
  def greet
    puts "Hello! My name is #{name}"
  end
end
  
kitty = Cat.new('Sophie')
kitty.greet
kitty.walk