class SumOfMultiples
  def initialize(*arguments)
    @set_of_numbers = arguments
  end

  def to(limit)
    @limit = limit
    
    multiples = @set_of_numbers.map do |number|
      count = 1
      results = []
      next_multiple = 0
      
      until next_multiple >= @limit 
        results << next_multiple.clone
        next_multiple = number * count
        count += 1
      end
      
      results
    end

    multiples.flatten.uniq.inject(:+)
  end

  def self.to(limit)
    self.new(3, 5).to(limit)
  end
end