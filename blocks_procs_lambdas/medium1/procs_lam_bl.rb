# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}" }
my_second_lambda = -> (thing) { puts "This is a #{thing}" } # New syntax.
puts my_lambda                  # It's a proc object with the word (lambda).
puts my_second_lambda         
puts my_lambda.class
my_lambda.call('dog')
# my_lambda.call                 # Must give correct number of arguments, unlike proc.
# my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}" } # This doesn't 
                  # work. Doesn't recognize Lambda as initializing a class instance.

# Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."} # Didn't pass the argument to the block.
# block_method_1('seal')              # Local jump error. Need to call with a block.

# Group 4
def block_method_2(animal)
  yield(animal)                        
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."} # Works, as expected.
block_method_2('turtle') do |turtle, seal|       # Only 1 variable passed, like a proc.
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}  # Missing variable for 'animal'.

# My analysis:
# Lambdas are a special type of Proc object. Unlike regular procs, they have strict 
# 'arity' rules - they are strict about number of variables passed. Procs and
# blocks have lenient arity. If variables are missing, procs/blocks fill in 
# with nil but lambdas raise errors. Too many variables passed, procs/blocks will ignore but
# lambda raises error.
# Lambdas and procs can both be created with a method call and block, like so:
#   my_proc = proc { |thing| puts "This is a #{thing}." }
#   my_lambda = lambda { |thing| puts "This is a #{thing}" }
# Proc.new also works, but Lambda.new does not.
# Also, a new syntax for creating a lambda: 
#   my_second_lambda = -> (thing) {puts "This is a #{thing}." }
