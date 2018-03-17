#A Pythagorean triplet is a set of three natural numbers, {a, b, c}, 
#for which, a**2 + b**2 = c**2.
#For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.

class Triplet
  def initialize(a,b,c)
    @triplet = [a, b, c].sort
  end

  def sum
    @triplet.reduce(&:+)
  end

  def product
    @triplet.reduce(&:*)
  end

  def pythagorean?
# input: have triplet
# output: boolean
# tests: (3,4,5) true 3**2 + 4**2 == 5**2
# (5,6,7) false
    @triplet[0]**2 + @triplet[1]**2 == @triplet[2]**2
  end

end