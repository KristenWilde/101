def check_return_with_proc
  my_proc = proc { puts "text1"; return; puts "text2" }
  my_proc.call
  puts "This will never output to screen."
end

check_return_with_proc

# 2

my_proc = proc { puts "A proc argument"; return }

def check_return_with_proc_2(my_proc)
  my_proc.call
end

# check_return_with_proc_2(my_proc) # LocalJumpError. I guess a proc argument can't have a return.

# 2.5

def check_with_implicit_block
  yield
  puts "This will not output"
end

# check_with_implicit_block { puts "output"; return } #LocalJumpError. I guess a block can't have a return.

# 3

def check_return_with_lambda
  my_lambda = lambda { return; puts "text after return" }
  my_lambda.call
  puts "This will be output to screen."
end

check_return_with_lambda
# The return in the lambda exits the lambda but not the whole method.

# Group 4
my_lambda = lambda { return; puts "text after return" }
def check_return_with_lambda(my_lambda)
  my_lambda.call
  puts "This will be output to screen."
end

check_return_with_lambda(my_lambda)

# Group 5
def block_method_3
  yield
end

block_method_3 { puts "text1"; return; puts "text2" }

# Conclusion:
# Using return to exit from an implicit block or an externally defined proc does 
# not work. When a block is defined within a method, return will exit the method.
# Return inside a lambda exits the lambda but allows the method to continue, 
# regardless of where the lambda is defined.