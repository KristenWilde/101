class Crypto
  def initialize(string)
    @original = string
    @normalized = normalize_plaintext
  end

  def normalize_plaintext
    @original.gsub(/[^A-Za-z0-9]/, "").downcase
  end

  def size
    @size = Math.sqrt(@normalized.length).ceil
  end

  def plaintext_segments
    @normalized.scan(Regexp.new(".{1,#{size}}"))
  end

  def ciphertext
    result = ""
    i = 0
    while (i < size) do
      plaintext_segments.each do |seg|
        result += seg[i] if seg[i]
      end
      i += 1
    end
    result
  end

  def normalize_ciphertext
    array = Array.new(size, "")
    i = 0
    while (i < size) do
      plaintext_segments.each do |seg|
        array[i] += seg[i] if seg[i]
      end
      i += 1
    end
    array.join(' ')
  end
end