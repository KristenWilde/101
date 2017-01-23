# Assertion or assert-style syntax

require 'minitest/autorun'
require 'minitest/reporters' # colors/formats the output
Minitest::Reporters.use!

require_relative 'car' # name of file to test, in the same folder.

class CarTest < MiniTest::Test  # inherits other methods needed to run tests.
  def test_wheels       # all tests are instance methods beginning with 'test_'
    car = Car.new              # instantiating an object for comparison
    assert_equal(4, car.wheels) # first param is the expected value (4), second is the actual, ie test value. 
  end
  
  def test_bad_wheels
    skip "this is a bad test" # keyword skip means skip this test. String is a message to the tester.
    car = Car.new
    assert_equal(3, car.wheels)
  end
end

# Types of assertions:
# assert(obj) - verifying that it exists
# assert_equal(a, b) - tests for equality with '==' (as defined in class)
# assert_nil(obj)
# assert_raises(ErrorName) {code}
# assert_instance_of(ClassName, obj)
# assert_includes(array, obj)