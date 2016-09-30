# ask the user for two numbers

Kernel.puts("Welcome to Calculator! \n What's the first number?")
number1 = Kernel.gets().chomp()
Kernel.puts("The number is: " + number1)
Kernel.puts("What's the second number?")
number2 = Kernel.gets().chomp()
Kernel.puts("The second is: " + number2)

# ask the user for an operation to perform

puts("What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide")
operator = Kernel.gets().chomp()

if operator == "1"
  result = number1.to_i() + number2.to_i()
elsif operator == "2"
  result = number1.to_i() - number2.to_i()
elsif operator == "3"
  result = number1.to_i() * number2.to_i()
end

Kernel.puts("The result is #{result}")

# perform the operation on the two numbers

# output the result

