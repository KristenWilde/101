require 'minitest/autorun'
require_relative 'text_class'
#require_relative 'sample'

class TextTest < MiniTest::Test
  def setup
    @file_obj = File.open("sample.txt")
    @text = Text.new(@file_obj.read)
  end
  
  def test_swap
    swapped = @text.swap('a', 'e')
    assert_equal(72, swapped.count('e'))
  end
  
  def test_word_count
    assert_equal(72, @text.word_count)
  end
  
  def teardown
    @file_obj.close
    puts "File has been closed: #{@file_obj.closed?}"
  end
end