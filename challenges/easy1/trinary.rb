class Trinary
  def initialize(tri_string)
    @tri_string = tri_string
  end

  def to_decimal
    return 0 unless valid?
    @tri_string
      .chars
      .reverse
      .map.with_index { |dig, pow| dig.to_i * (3**pow) }
      .reduce(:+)
  end

  def valid?
    @tri_string.match(/^[0-3]+$/)
  end
end

p Trinary.new('10').to_decimal