=begin
Calculate hamming distance - a measure of the minimum number of point
mutations that could have occurred between the two strands of DNA
of equal length.
Count how many bases are different using a counter.
Loop through the strings using an index.
  Increment the counter when the chars don't match.
  Break the loop if one of the chars is false.

=end
class DNA
  def initialize(strand1)
    @strand1 = strand1
  end

  def hamming_distance(strand2)
    idx = 0
    counter = 0
    loop do
      base1 = @strand1[idx] || break
      base2 = strand2[idx] || break
      counter += 1 if base1 != base2
      idx += 1
    end
    counter
  end
end