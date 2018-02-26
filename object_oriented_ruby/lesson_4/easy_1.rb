# 1. All are objects. Use #class to find out what class.

# 2. Within the Car and Truck class, insert `include Speed`. Test by 
#    instantiating a new car and truck and calling .go_fast

# 3. The .go_fast method includes an interpolation of self.class, which will be 
#    the class name of the calling object.

# 4. sam = AngryCat.new

# 5. Pizza. The instance variable starts with @
#    We could also use the #instance_variables method on an instance of the 
#    class. It would return an array containing the symbol names of all 
#    instance_variables.

# 6. To be able to access an instance variable, we need a getter method. 
#    Could also be attr_reader or attr_accessor.
#    Or, technicall we don't need to add anything to the class, if we use the 
#    method #instance_variable_get("@variable_name_in_a_string")

# 7. .to_s default is < Classname:object id encoding > 

# 8. Within an instance method, self refers to the calling object.

# 9. As part of a class method definition, self refers to the class.

# 10. Bag.new("pink", "leather")

