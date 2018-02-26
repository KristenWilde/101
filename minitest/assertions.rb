require 'minitest/autorun'

require_relative 'file'

class BooleanTest < MiniTest::Test
  def test_boolean
    assert_equal(true, value.odd?)
  end
  
  def test_downcase
    assert_equal('xyz', value.downcase)
  end
  
  def test_nil
    assert_nil(value)
  end
  
  def test_list_empty
    assert_empty(list)
  end
  
  def test_list
    assert_includes(list, 'xyz')    
  end
  
  def test_exception
    assert_raises(NoExperienceError) {employee.hire}
  end
  
  def test_object_type
    assert_instance_of(Numeric, value)
  end
  
  def test_kind
    assert_kind_of(Numeric, value)
  end
  
  def test_same_objects
    assert_same(list, list.process)
  end
  
  def test_not_in_array
    refute_includes(list, 'xyz')
  end
end

# file.rb includes:
# class NoExperienceError < StandardError ; end