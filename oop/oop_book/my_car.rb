
module Towable
  def tow(thing)
    puts "I'll tow your #{thing}"
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model

  @@number_of_vehicles = 0
  
  def self.number_of_vehicles
    @@number_of_vehicles
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} mpg"
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vehicles += 1
  end
  
  def speed_up(diff)
    self.speed += diff
  end
  
  def brake(diff)
    self.speed -= diff
  end
  
  def shut_off
    self.speed = 0
  end

  def spray_paint(new_color)
    self.color = new_color
  end
  
  def age 
    calculate_age
  end
  
  private
  
  def calculate_age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  TYPE = "car"
  
  def to_s
    "My car is a #{color} #{year} #{model}"
  end 
end

class MyTruck < Vehicle
  include Towable
  TYPE = "truck"
    
  def to_s
    "My truck is a #{color} #{year} #{model}"
  end 
end

puts Vehicle.number_of_vehicles

red = MyCar.new(2011, "red", "yaris")
red.speed_up(30)
puts red.speed
red.speed_up(35)
puts red.speed
puts red.color
red.spray_paint('hot pink')
puts red.color
MyCar.gas_mileage(13, 351)
puts red.to_s
puts red

mater = MyTruck.new(1958, "blue", "tow truck")
puts mater
mater.speed_up(30)
puts mater.speed
mater.speed_up(35)
puts mater.speed
puts mater.color
mater.spray_paint('hot pink')
puts mater.color
MyTruck.gas_mileage(13, 351)

puts Vehicle.number_of_vehicles
mater.tow("boat")

p MyCar.ancestors
p MyTruck.ancestors

puts red.age
puts mater.age

# 7.

class Student
  attr_accessor :name
  attr_writer :grade
  
  def better_grade_than?(other_student)
    puts "Well done!" if self.grade.to_i > other_student.grade.to_i
  end
  
  protected
  
  attr_reader :grade
end

joe = Student.new
bob = Student.new
joe.grade = 88
bob.grade = 75

joe.better_grade_than?(bob)

# 8.

# The problem is that the method 'hi' is defined below the word 'private' within the class.
# Fix the problem by moving it to the public section of the class.