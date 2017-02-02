
# 1. 

class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end

# 2.

class Person
  attr_accessor :first_name, :last_name
  
  def initialize(name)
    @first_name = name.split(' ')[0]
    @last_name = name.split(' ')[1] || ""    # works if there are only 2 names (no )
  end
  
  def name
    "#{first_name} #{last_name}".strip   # because if there's just a first name, a space is added. #strip removes it.
  end
end

bob = Person.new('Robert')
p bob.name                 
p bob.first_name            
p bob.last_name             
bob.last_name = 'Smith'
p bob

# 3.

class Person
  attr_accessor :first_name, :last_name  # initializes the variables.
  
  def initialize(name)
    parse_full_name(name)
  end
  
  def name
    "#{first_name} #{last_name}".strip  
  end
  
  def name=(string)
    parse_full_name(string)
  end
  
  private
  
  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size == 1 ? "" : parts.last
  end
end

kelly = Person.new("Kel")
p kelly
kelly.name = "Kelly Wilde"
p kelly.first_name
p kelly.last_name

# 4.

class Person
  attr_accessor :first_name, :last_name  # initializes the variables.
  
  def initialize(name)
    parse_full_name(name)
  end
  
  def name
    "#{first_name} #{last_name}".strip  
  end
  
  def name=(string)
    parse_full_name(string)
  end
  
  def same_name?(other_person)
    self.name == other_person.name
  end
  
  private
  
  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size == 1 ? "" : parts.last
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
p bob.same_name?(rob)

# 5. Would print "The person's name is: #<Person:objectid>"

puts "The person's name is: #{bob}"

# 6. Would print "The person's name is: Robert Smith"