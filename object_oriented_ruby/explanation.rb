# Explain with examples:
# 1. Classes and objects

# A class is like a mold or blueprint for an object; it outlines the attributes
# and behaviors the object should have. An object is an instance of a class, 
# the thing created from the blueprint.

class ToyTrain
  def initialize(color, name)
    @color = color   # attributes are contained in variables
    @name = name
  end
  
  def drive   # behaviors are defined by methods the class has.
  end
  
  def crash
  end
end

my_train = ToyTrain.new("blue", "Thomas")

# 2. Setter and getter methods, how to create them with attr_*, and how to call them

# Getter methods get the value of an instance variables, and setter methods set the 
# Writing a getter and setter within the class:
class ToyTrain
  # . . . 

  def color
    @color
  end

  def color=(new_color)
    @color = new_color
  end

# attr_ methods are shortcuts

  attr_reader :color
  attr_writer :color
  attr_accessor :color, :name
end

# how to call them:

my_train.color #=> "blue"
my_train.color = "red"
my_train.color #=> "red"

# Within methods inside the class definition, getters & setters can be called
# on an instance with the word 'self'. Getters can be called simply with the 
# variable name.

class ToyTrain
  # . . .
  
  def paint(new_color)
    puts "#{name} is getting a fresh coat of paint!"
    self.color = new_color
  end
end
    

# 3. Instance methods vs. class methods
# Instance methods are called on an instance of the class. 
# Class methods are called on the class itself.

# Class methods we might want:
# A. ToyTrain.ghost_whistle  # A spooky whistle sounds. Not sure where it came from.

class ToyTrain
  def self.ghost_whistle
    puts "(whooooo . . .) "
  end
end

ToyTrain.ghost_whistle

# B. ToyTrain.list_trains   # Doesn't apply to any one train instance. We could 
                            # use a class variable to keep track of 
                            # train instances created.
class ToyTrain
  @@all_trains = []
  
  def initialize(color, name)
    @color = color   # attributes are contained in variables
    @name = name
    @@all_trains << @name
  end
  
  def self.list_trains
    puts @@all_trains
  end
end

gordon = ToyTrain.new("blue", "Gordon")
james = ToyTrain.new("red", "James")
ToyTrain.list_trains
    
# 4. Referencing and setting an instance variable vs using getter/setter methods

# The advantage of using getter/setter methods is that the variable can be 
# easily altered or formatted, and this can be easily changed in the future if desired.

def name
  @name.capitalize
end

# 5. Class inheritance

# Classes can inherit states and behaviors from other classes, with a 
# hierarchical superclass/subclass relationship.   

class StuffedAnimal
  attr_accessor :owner
  
  def put_away
    puts "♫ Clean up, clean up, clean up ♫"
  end
end

class Shark < StuffedAnimal
  
  def put_away
    super
    puts "#{owner}'s shark is put away."
  end
end

sharky = Shark.new
sharky.owner = "Zach"
sharky.put_away

# 6. Modules
# Modules are containers for methods or classes.  They can be used for 
# A. namespacing classes or methods, or 

module Toys
  # define toy classes here, to differentiate them from real sharks, trains, 
  # cats, princesses, etc.
  
  class Car; end

  class Food; end
end

Toys::Car.new # reference with two colons.

# B. for mixing in a group of methods not heirarchically related.

module BatteryOperated
  
  def turn_on; end
  
  def turn_off; end
    
  def replace_batteries; end
end

class BatteryTrain < ToyTrain
  include BatteryOperated
  
end

class Flashlight
  include BatteryOperated
  
end

# 7. Method Lookup Path
# When looking for the implementation of a method called on an object, 
# Ruby looks first to its class, then its modules (starting at the bottom of 
# the list and going up), then to its superclass, then to any modules included 
# in the superclass. The method lookup path can be seen by calling the method 
#  `#ancestors` on the class name.

p BatteryTrain.ancestors
# => [BatteryTrain, BatteryOperated, ToyTrain, Object, Kernel, BasicObject]

# 8. Self
# The word ‘self’ is a way of being explicit about what a method is referencing. 
# When used within the implementation of an instance method, it references an 
# instance of an object. When used in a method title, it references the class itself.

# 9. Fake operators
# Many Ruby methods look like operators, but are actually methods. 
# Comparison, equality, and math operators, for example. 
# Because they’re methods, they can be overridden (re-defined) within a custom class. 

class ToyTrain
  @@all_trains = []
  attr_reader :name
  
  def initialize(color, name)
    @color = color   # attributes are contained in variables
    @name = name
    @@all_trains << self
  end
  
  def >(other_train)
    @@all_trains.index(self) < @@all_trains.index(other_train)
  end
end

gordon = ToyTrain.new("blue", "Gordon")
james = ToyTrain.new("red", "James")

puts gordon > james  # => true
puts james > gordon  # => false

# 10. Truthiness
# In Ruby, everything is 'truthy' except 'false' and 'nil'.
# This is useful for writing methods.

class StuffedAnimal
  attr_accessor :owner  

  def find
    if owner then puts "I belong to #{owner}."
    else puts "I have no owner."
    end
  end
end

StuffedAnimal.new.find

# 11. Working with Collaborator Objects

# Collaborator objects are objects of classes which work together. An instance
# variable of one class may point to an instance of another class. Or to a collection
# array/hash/set of other objects.

class ToyFactory
  attr_reader :inventory
  
  def initialize
    @inventory = {}
  end
  
  def make_trains(num, color, name)
    num.times do |count|
      @inventory["train" + count.to_s] = ToyTrain.new(color, name)
    end
  end
end

factory = ToyFactory.new
factory.make_trains(5, "blue", "Thomas")
p factory.inventory

# - - - - - - 

# # Instance variables vs class variables
# # Instance variables pertain to an instance of the object (@color and @name). 
# # Class variables pertain to the class itself.

# class ToyTrain
#   @@total_trains = 0
#   @@lost_trains = []
#   # . . .

#   def initialize(color, name)
#     @color = color  
#     @name = name
#     @@total_trains += 1
#   end
  
#   def lose
#     puts "Oh no, #{name} is missing! " \
#         "Maybe it's #{["in the sandbox", "under the bed"].sample}."
#     @@lost_trains << name
#   end
  
#   def self.list_lost_trains
#     puts "Trains I Can't Find:"
#     puts @@lost_trains
#   end
# end

# ToyTrain.new("blue", "Thomas").lose
# ToyTrain.list_lost_trains