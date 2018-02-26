# as is, output will be
# Fluffy
# My name is FLUFFY
# FLUFFY
# FLUFFY

# Fixed:

class Pet
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    @name << " Muff"
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
name.upcase!
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# Further exploration

# 42
# My name is 42.
# 42
# 43

# name = 42
# fluffy = Pet.new(name)
# name += 1
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name