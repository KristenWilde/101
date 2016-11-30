
class MyCar
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end
  
  attr_accessor :color, :speed
  attr_reader :year, :model
  
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
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} mpg"
  end
  
  def to_s
    "#{color} #{year} #{model}"
  end
end



red = MyCar.new(2011, "red", "yaris")
# red.speed_up(30)
# puts red.speed
# red.speed_up(35)
# puts red.speed
# puts red.color
# red.spray_paint('hot pink')
# puts red.color
# MyCar.gas_mileage(13, 351)
# puts red.to_s
puts red

