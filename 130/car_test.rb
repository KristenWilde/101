# Assertion or assert-style syntax

require 'minitest/autorun'
require 'minitest/reporters' # colors/formats the output
Minitest::Reporters.use!

require_relative 'car' # name of file to test, in the same folder.

class CarTest < Minitest::Test  # inherits other methods needed to run tests.
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
# assert_empty(array)
# assert_kind_of(ClassName, obj) - uses Object#kind_of to check whether the
#     object is an instance of the named class or one of its superclasses.
# assert_output("output string ending with \n") { code } - uses stdout 

# All of the assertions have a correstponding refute method!
# refute_includes(array, obj) will pass only if the array does not include the obj.