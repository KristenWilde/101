#A Pythagorean triplet is a set of three natural numbers, {a, b, c}, 
#for which, a**2 + b**2 = c**2.
#For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.

class Triplet
  def initialize(*arguments)
    @triplet = arguments.flatten.sort
  end

  def sum
    @triplet.reduce(&:+)
  end

  def product
    @triplet.reduce(&:*)
  end

  def pythagorean?
    @triplet[0]**2 + @triplet[1]**2 == @triplet[2]**2
  end

  def self.where(inputs)
    max_factor = inputs[:max_factor]
    min_factor = inputs[:min_factor] || 1
    sum = inputs[:sum]

    all_triplets = (min_factor..max_factor).to_a.combination(3).to_a
    all_triplets.map! { |triplet| Triplet.new(triplet) }
    if sum 
      all_triplets.select! { |triplet| triplet.sum == sum } 
    end
    all_triplets.select { |triplet| triplet.pythagorean? }
  end
end
