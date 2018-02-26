module Moving
  def walk
    puts "#{self} #{gait} forward"
  end
  
end

class Noble
  include Moving
  attr_reader :name, :title
  
  def initialize(name, title)
    @name = name
    @title = title
  end
  
  def to_s
    name + " " + title
  end
  
  private
  
  def gait
    "struts"
  end
end

class Person
  include Moving
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end

  private

  def gait
    "strolls"
  end
end


class Cat
  include Moving
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end
  
  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Moving
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end
  
  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
byron.walk