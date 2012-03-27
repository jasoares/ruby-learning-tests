require File.expand_path('../test_helpers', __FILE__)

class TestNumerics < MiniTest::Unit::TestCase

  def setup
    @fixnum1 = 1
    @fixnum2 = 1
    @float1 = 1.0
  end

  def test_numeric_objects_equality
    assert_equal @fixnum1, @float1, "Should be equal as both have the same content and type is not checked"
    assert !(@fixnum1.eql? @float1), "Should not be eql? since they have different types"
    assert @fixnum1.eql?(@fixnum2), "Should be equal in content and type"
  end

  def test_integer_times_iterator
    x = 0; y = 0
    4.times { x += 1 }
    assert_equal 4, x, "x should be equal to 3 after the iterator"
  end

  def test_integer_times_iterator_with_parameter
    x = 0
    4.times { |i| x += i }
    assert_equal 6, x, "x should be equal to 6 after the iterator"
  end

  def test_integer_upto_iterator
    factorial = 1
    1.upto(4) { |x| factorial *= x }
    assert_equal 24, factorial, "should be equal to 1 * 2 * 3 * 4"
  end

  def test_step_iterator
    res = []
    0.step(10, 2) { |x| res << x }
    assert_equal [0, 2, 4, 6, 8, 10], res, "should assign res with an array with even elements from 0 to 10"
  end

end