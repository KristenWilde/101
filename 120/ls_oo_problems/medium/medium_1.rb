# 1. Privacy

class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end
  
  def state
    switch
  end
  
  private
  
  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

wall_e = Machine.new
# p wall_e.start
p wall_e.state