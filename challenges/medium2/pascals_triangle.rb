=begin
Write a program that computes Pascal's triangle up to a given number of rows.
In Pascal's Triangle each number is computed by adding the numbers to the right
 and left of the current position in the previous row.

 Triangle.new(3).rows => [[1], [1,1], [1,2,1]]
 Triangle.new(4).last => [1, 3, 3, 1]
=end

class Triangle
  def initialize(size)
    @size = size
    @triangle = [[1]]
  end

  def rows
    (@size - 1).times do |idx|
      @triangle << next_row_for(@triangle.last)
    end
    @triangle
  end

  def next_row_for(current_row)
    result = []
    current_row.each_with_index do |num, idx|
      idx == 0 ? result << 1 : result << num + current_row[idx - 1]
    end
    result << 1
  end

end
