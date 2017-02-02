
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

teddy = Dog.new
puts teddy.speak           
puts teddy.swim  

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

# 2.

class Mammal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Mammal
  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Mammal
  def speak
    'meow!'
  end
end

# 3.   Pet 
  #   /   \
  # Dog    Cat
  # |
  # Bulldog

# 4. The method lookup path is the order in which classes/modules are checked for methods.
#    It is important to identifying where a method comes from, especially where different methods may have the same name.