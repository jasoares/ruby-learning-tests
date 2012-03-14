require 'test/unit'

class TestIterators < Test::Unit::TestCase

  def test_times_iterator
    x = 0; y = 0
    4.times { x += 1 }
    assert_equal 4, x, "x should be equal to 3 after the iterator"
  end

  def test_times_iterator_with_parameter
    x = 0
    4.times { |i| x += i }
    assert_equal 6, x, "x should be equal to 6 after the iterator"
  end

  def test_each_iterator
    ary = [1, 2, 3]; res = []
    ary.each { |e| res << e += 1 }
    assert_equal [2, 3, 4], res, "should assign res with ary's elements incremented by 1"
  end

  def test_each_index_iterator
    ary = [1, 2, 3]; res = []
    ary.each_index { |i| res << ary[i] * i }
    assert_equal [0, 2, 6], res, "should assign res with ary's elements multiplied by their indexes"
  end

  def test_map_iterator
    ary = [1, 2, 3];
    res = ary.map { |e| e*e }
    assert_equal [1, 4, 9], res, "should return an array with the square of ary's elements"
  end

  def test_upto_iterator
    factorial = 1
    1.upto(4) { |x| factorial *= x }
    assert_equal 24, factorial, "should be equal to 1 * 2 * 3 * 4"
  end

  def test_loop_iterator
    x = 0
    loop { x += 1; break if x > 3 }
    assert_equal 4, x, "should break the loop when x = 4"
  end

  def test_step_iterator
    res = []
    0.step(10, 2) { |x| res << x }
    assert_equal [0, 2, 4, 6, 8, 10], res, "should assign res with an array with even elements from 0 to 10"
  end

end
