# 1.

class SecretFile
  def initialize(secret_data)
    @data = secret_data
    @log = SecurityLogger.new
  end
  
  def data
    @log.create_log_entry
    @data
  end
end

class SecurityLogger
  def create_log_entry(access_type)
    #
  end
end

# 2.

module GasVehicle
  attr_accessor :speed, :heading
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
  
end

class WheeledVehicle
  include GasVehicle

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  include GasVehicle
  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end
end

yaris = Auto.new
kate = Motorcycle.new
sally = Catamaran.new(2, 3, 60, 18.0)

puts yaris.range
puts kate.range
puts sally.range

# 3. 

class SeaCraft 
  include GasVehicle
  
  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end
end

class Motorboat < SeaCraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end  

class Catamaran <SeaCraft
end

# 4. 

class SeaCraft
  # code as above. Add:
  
  def range
    super + 10
  end
end