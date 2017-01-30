class Series
  def initialize(string)
    @num_array = string.chars.map(&:to_i)
  end
  
  def slices(n)
    raise ArgumentError if n > @num_array.size
    results = []
    @num_array.each_cons(n) { |mini| results << mini }
    results
  end
end
