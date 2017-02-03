# very basic program, just recipes to shopping list:

class InterfaceEngine
  def initialize
  end
  
  def start
    start_message
    loop do
      get_recipe
      break unless another_recipe?
    end
    print_list
  end
end