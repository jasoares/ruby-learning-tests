require File.expand_path('../test_helpers', __FILE__)
require 'point'

class TestSampleClass < MiniTest::Unit::TestCase

  def setup
    @p = Point.new(2, 1)
    @q = Point.new(1, 2)
  end

  def test_class_instantiation
    assert_equal [2, 1], [@p.x, @p.y]
  end

  def test_object_attribute_assignment
    @p.x, @p.y = 1, 2
    assert_equal [1, 2], [@p.x, @p.y]
  end

  def test_equal_operator
    assert_equal Point.new(@p.x, @p.y), @p
  end

  def test_object_equality1
    assert Point.new(@p.x, @p.y) == @p
  end

  def test_object_equality2
    assert_equal Point.new(@p.x, @p.y), @p
  end

  def test_object_equality3
    assert Point.new(@p.x, @p.y).eql?(@p)
  end

  def test_object_equality4
    assert Point.new(@p.x, @p.y).eql?(@p) && Point.new(@p.x, @p.y).hash == @p.hash,
    "If two object are considered equal to the eql? method they should produce the same hash"
  end

  def test_binary_plus_operator
    assert_equal Point.new(@p.x + @q.x, @p.y + @q.y), @p + @q
  end

  def test_binary_minus_operator
    assert_equal Point.new(@p.x - @q.x, @p.y - @q.y), @p - @q
  end

  def test_type_error_raised_on_plus_operator
    assert_raises(TypeError) {
      @p + 3
    }
  end

  def test_unary_minus_operator
    assert_equal Point.new(-2, -1), -@p
  end

  def test_unary_plus_operator
    assert_equal Point.new(2, 1), +@p
  end

  def test_times_scalar_operator
    assert_equal Point.new(4, 2), @p * 2
  end

  def test_coerce_method
    assert_equal Point.new(4, 2), 2 * @p
  end

  def test_times_scalar_operation_is_symmetric
    assert_equal @p * 2, 2 * @p
  end

  def test_array_access_operator1
    assert_equal [@p.x, @p.y], [@p[0], @p[1]]
  end

  def test_array_access_operator2
    assert_equal [@p.x, @p.y], [@p[-2], @p[-1]]
  end

  def test_hash_access_operator1
    assert_equal [@p.x, @p.y], [@p[:x], @p[:y]]
  end

  def test_hash_access_operator2
    assert_equal [@p.x, @p.y], [@p["x"], @p["y"]]
  end

  def test_each_method
    ary = []
    assert_equal [@p.x, @p.y], @p.each { |c| ary << c }
  end

  def test_enumerable_module_mixin
    assert_equal [@p.x, @p.y], @p.map { |c| c }
  end

  def test_to_s_method
    assert_equal "#{@p.x}, #{@p.y}", @p.to_s
  end

end