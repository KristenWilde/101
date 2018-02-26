def factorial(number)
  number.downto(2) do |num|
    number = number * (num - 1)
  end
  number
end

factorial_enumerator = Enumerator.new do |factorials|
  n = 0
  loop do 
    factorials << factorial(n)
    n += 1
  end
end

# External iteration:
7.times { puts factorial_enumerator.next }

factorial_enumerator.rewind

# Internal iteration:
factorial_enumerator.each { |element| puts element; break if element > 1000 }

