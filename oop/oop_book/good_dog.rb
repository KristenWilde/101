

module Speak
  def speak(words="Hello")
    puts words
  end
end

class Animal             # superclass
  def sleep
    puts "zzz zzzz zzzzzzz"
  end
  def eat
    puts 'yum yum!'
  end
end

class GoodDog < Animal    # GoodDog is a subclass of Animal. Inherits all its methods.
  include Speak           # mixing in a module inherits all its methods.
  @@number_of_dogs = 0      # class variable

  def initialize(n, h, w)   # #initialize is called when GoodDog.new is called
    @name = n
    @height = h
    @weight = w
    @@number_of_dogs += 1   # accessing a class variable within an instance method
  end

  def self.total_number_of_dogs  # class method. 'self' refers to the class itself, GoodDog.
    @@number_of_dogs
  end
  
  def eat                         # overrides Animal's eat method.
    puts "[munch munch] Woof!"
  end
  
  def wag
    "#{@name}'s tail is wagging!" # uses the instance variable
  end
  
  def name          # getter method
    @name
  end
  
  def name=(new_name)  # setter method 
    @name = new_name
  end
  
  attr_accessor :name, :height, :weight    # creates getter and setter methods for 3 instance variables using symbols

  def info 
    "#{name} weighs #{weight} lbs and is #{height} inches tall."
  end                               # uses the getter method, not the instance variable.

  def change_info(n, h, w)          # uses the setter methods, not the instance variable.
    self.name = n                   # We must use 'self' because 'name = n' would just create a local variable 'name'.
    self.height = h                 # 'self' refers to the calling object, which would be an instance of GoodDog.
    self.weight = w
  end

  def to_s     # overrides the default to_s method. Is called with puts and #{ }
    self.name.to_s  
  end
end

class Puppy < GoodDog
  DOG_YEARS = 7             # constant, will never change. Must begin with capital letter, usually all uppercase.
  def initialize(n, h, w, age)
    super(n, h, w)
    @age = age
  end
  
  attr_writer :age
  
  def age
    @age * DOG_YEARS
  end
end  

fido = GoodDog.new("Fido", 14, 25)

fido.speak("Woof")
#=> Woof

puts fido.wag
#=> "Fido's tail is wagging!"

puts fido.name
#=> "Fido"

fido.name = "Fidelius"
puts fido.name
#=> "Fidelius"

puts fido.info

puts GoodDog.total_number_of_dogs
spot = GoodDog.new("Spot", 18, 30)
puts GoodDog.total_number_of_dogs

puts spot
fido.eat
fido.sleep

curly = Puppy.new("Curly", 7, 10, 1)

puts curly
# puts Puppy.ancestors
puts curly.age



# Notes:

# When defining a class,
#   states: track attributes for individual objects with instance variables
#   behaviors: what objects can do, using instance methods.
  
# name=(new_name) is syntactical suger. Can be called with assignment syntax:
#   fido.name = "Fidelius"
  
# attr_accessor sets up getter and setter methods for 1 or more instance variables
# attr_reader  - getter method only
# attr_writer  - setter method only

# Using getter methods rather than instance variables directly makes it possible to
# alter them for use. For example, obscuring all but the last 4 digits of a ssn with 
# the method below. '@ssn' will be the entire number. 'ssn' will be x's and the last 4. 

def ssn                                # getter method for retrieving the ssn
  'xxx-xx-' + @ssn.split('-').last
end

# 3 uses for modules:

# 1. Modules for mixins.

# 2. Modules for namespacing: grouping similar classes under a module to keep codebase 
# organized. Useful for differentiating from other similarly-named classes.

module Toys
  class Puppy    # not to be confused with GoodDog::Puppy
  end
  
  class Woody
    include Speak
    def pull_string
      self.speak("There's a snake in my boot")
    end
  end

end

podogo = Toys::Puppy.new
# puts podogo

woody = Toys::Woody.new
woody.pull_string

# 3. Modules as a container for methods (module methods) that seem out of place.

module Mammal
  # ...
  def self.some_out_of_place_method(num)
    num ** 2
  end 
end

value = Mammal.some_out_of_place_method(4)
# or, less preferred:
value = Mammal::some_out_of_place_method(4)

