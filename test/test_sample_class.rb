require File.expand_path('../test_helpers', __FILE__)
require 'point'

class TestSampleClass < MiniTest::Unit::TestCase

  def setup
    Point.reset;
    @p = Point.new(2, 1)
    @q = Point.new(1, 2)
    @r = Point.new(2, 1)
  end

  def test_class_instantiation
    assert_equal [2, 1], [@p.x, @p.y]
  end

  def test_object_attribute_assignment
    @p.x, @p.y = 1, 2
    assert_equal [1, 2], [@p.x, @p.y]
  end

  def test_equal_operator
    assert_equal @r, @p
  end

  def test_object_equality1
    assert @r.eql?(@p)
  end

  def test_object_equality2
    refute_equal @q, @p
  end

  def test_object_equality4
    assert_block do
      if @r.eql?(@p)
        @r.hash == @p.hash
      else
        false
      end
    end
  end

  def test_binary_plus_operator
    assert_equal Point.new(@p.x + @q.x, @p.y + @q.y), @p + @q
  end

  def test_binary_minus_operator
    assert_equal Point.new(@p.x - @q.x, @p.y - @q.y), @p - @q
  end

  def test_type_error_raised_on_plus_operator_when_fixnum_is_provided
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

  def test_hash_method_returns_different_hash_value_for_simmetric_points
    refute_equal @p.hash, @q.hash
  end

  def test_hash_method_returns_same_hash_value_for_equal_instances
    assert_equal @r.hash, @p.hash
  end

  def test_ordering_equality_doesnt_mean_instance_equality
    refute_equal((@p <=> @q) == 0, @p == @q)
  end

  def test_equal_instances_get_the_same_order
    assert_equal(@p == @r, (@p <=> @r) == 0)
  end

  def test_spaceship_operator
    assert_equal 0, @p <=> @q
    assert_equal(-1, @p <=> Point.new(2, 2))
    assert_equal 1, @p <=> Point.new(2, 0)
  end

  def test_less_than_operator
    assert @p < Point.new(2,2)
  end

  def test_less_than_or_equal_operator
    assert @p <= @r
    assert @p <= @q
  end

  def test_greater_than_operator
    assert @p > Point.new(1, 1)
  end

  def test_greater_than_or_equal_operator
    assert @p >= @r
    assert @p >= @q
  end

  def test_to_s_method
    assert_equal "(#{@p.x}, #{@p.y})", @p.to_s
  end

  def test_add_mutator_method
    p = @p.dup
    @p.add!(@q)
    assert_equal p + @q, @p
  end

  def test_add_nonmutator_method_same_as_plus_operator
    assert_equal @p + @q, @p.add(@q)
  end

  def test_class_method_sum
    assert_equal Point.new(5, 4), Point.sum(@p, @q, @r)
  end

  def test_class_method_report
    n = 3; totalX = 5.to_f/n; totalY = 4.to_f/n
    exp = <<REPORT
Number of points created: #{n}
Average X coordinate: #{totalX}
Average Y coordinate: #{totalY}
REPORT
    assert_output(exp) do
      Point.report
    end
  end

end
