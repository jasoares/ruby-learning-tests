require File.expand_path('../test_helpers', __FILE__)
require 'sample_enumerable'

class TestIterators < MiniTest::Unit::TestCase

  def setup
    @ary1 = [1, 2, 3, 4, 5]
    @senum1 = SampleEnumerable.new([1, 2, 3, 4, 5])
    @ary2 = ['a', 'b', 'c', 'd']
    @senum2 = SampleEnumerable.new(['a', 'b', 'c', 'd'])
  end

  def test_iterator_map_twice1
    a = @ary1.map { |e| e + 2 }
    assert_equal a, @senum1.map_twice { |e| e + 1 }
  end

  def test_iterator_map_twice2
    a = @ary2.map { |s| s << s*3 }
    assert_equal a, @senum2.map_twice { |s| s << s }
  end

  def test_iterator_collect_with_double
    a = @ary1.map { |e| e + e*2 }
    assert_equal a, @senum1.collect_with_double { |e, d| e + d }
  end

  def test_iterator_increment_by_value
    a = @ary1.map { |e| e + 2 }
    assert_equal a, @senum1.increment_by(2)
  end

  def test_iterator_increment_by_value_with_block
    a = []
    @ary1.inject(1) { |inc, e| a << e + inc; inc + 1 }
    assert_equal a, @senum1.increment_by(1) { |inc, e| inc + 1 }
  end

end
