class Robot
  attr_reader :name
  @@taken_names = [] 
  
  def initialize
    assign_name
  end

  def reset
    assign_name
  end
  
  private

  def assign_name
    loop do
      new_name = generate_name
      unless @@taken_names.include?(new_name)
        @name = new_name
        break
      end
    end
    @@taken_names << name
  end

  def generate_name
    (('A'..'Z').to_a.sample(2) + ('0'..'9').to_a.sample(3)).join
  end

end

bob = Robot.new

p bob.name