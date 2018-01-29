class Sieve
  def initialize(limit)
    @limit = limit
    @numbers = (2..limit).to_a
  end

  def primes
    idx = 0
    current =nil
    multiple = nil
    loop do 
      current = @numbers[idx]
      multiple = current
      until multiple > @limit do
        multiple += current 
        @numbers.delete(multiple)
      end 
      idx += 1;
      break if idx >= @numbers.length
    end
    @numbers
  end
end

