require File.expand_path('../test_helpers.rb', __FILE__)
require 'point3d'

class TestSampleSubclass < MiniTest::Unit::TestCase

  def setup
  	Point3D.reset
    @p3d = Point3D.new(2, 1, 1)
    @q3d = Point3D.new(1, 1, 2)
    @r3d = Point3D.new(2, 1, 1)
  end

  def test_class_instantiation
    assert_equal [2, 1, 1], [@p3d.x, @p3d.y, @p3d.z]
  end

  def test_object_attribute_assignment
    @p3d.x, @p3d.y, @p3d.z = 1, 2, 3
    assert_equal [1, 2, 3], [@p3d.x, @p3d.y, @p3d.z]
  end

  def test_equal_operator
    assert_equal @r3d, @p3d
  end

  def test_object_equality1
    assert @r3d.eql?(@p3d)
  end

  def test_object_equality2
    refute_equal @q3d, @p3d
  end

  def test_object_equality4
    assert_block do
      if @r3d.eql?(@p3d)
        @r3d.hash == @p3d.hash
      else
        false
      end
    end
  end

  def test_binary_plus_operator
    assert_equal Point3D.new(@p3d.x + @q3d.x, @p3d.y + @q3d.y, @p3d.z + @q3d.z), @p3d + @q3d
  end

  def test_binary_minus_operator
    assert_equal Point3D.new(@p3d.x - @q3d.x, @p3d.y - @q3d.y, @p3d.z - @q3d.z), @p3d - @q3d
  end

  def test_type_error_raised_on_plus_operator_when_fixnum_is_provided
    assert_raises(TypeError) {
      @p3d + 3
    }
  end

  def test_unary_minus_operator
    assert_equal Point3D.new(-2, -1, -1), -@p3d
  end

  def test_unary_plus_operator
    assert_equal Point3D.new(2, 1, 1), +@p3d
  end

  def test_times_scalar_operator
    assert_equal Point3D.new(4, 2, 2), @p3d * 2
  end

  def test_coerce_method
    assert_equal Point3D.new(4, 2, 2), 2 * @p3d
  end

  def test_times_scalar_operation_is_symmetric
    assert_equal @p3d * 2, 2 * @p3d
  end

  def test_array_access_operator1
    assert_equal [@p3d.x, @p3d.y, @p3d.z], [@p3d[0], @p3d[1], @p3d[2]]
  end

  def test_array_access_operator2
    assert_equal [@p3d.x, @p3d.y, @p3d.z], [@p3d[-3], @p3d[-2], @p3d[-1]]
  end

  def test_hash_access_operator1
    assert_equal [@p3d.x, @p3d.y, @p3d.z], [@p3d[:x], @p3d[:y], @p3d[:z]]
  end

  def test_hash_access_operator2
    assert_equal [@p3d.x, @p3d.y, @p3d.z], [@p3d["x"], @p3d["y"], @p3d["z"]]
  end

  def test_each_method
    ary = []
    assert_equal [@p3d.x, @p3d.y, @p3d.z], @p3d.each { |c| ary << c }
  end

  def test_enumerable_module_mixin
    assert_equal [@p3d.x, @p3d.y, @p3d.z], @p3d.map { |c| c }
  end

  def test_hash_method_returns_different_hash_value_for_simmetric_points
    refute_equal @p3d.hash, @q3d.hash
  end

  def test_hash_method_returns_same_hash_value_for_equal_instances
    assert_equal @r3d.hash, @p3d.hash
  end

  def test_ordering_equality_doesnt_mean_instance_equality
    refute_equal( (@p3d <=> @q3d) == 0, @p3d == @q3d )
  end

  def test_equal_instances_get_the_same_order
    assert_equal(@p3d == @r3d, (@p3d <=> @r3d) == 0)
  end

  def test_spaceship_operator
    assert_equal 0, @p3d <=> @q3d
    assert_equal(-1, @p3d <=> Point3D.new(2, 2, 2))
    assert_equal 1, @p3d <=> Point3D.new(2, 0, 0)
  end

  def test_less_than_operator
    assert @p3d < Point3D.new(2, 2, 1)
  end

  def test_less_than_or_equal_operator
    assert @p3d <= @r3d
    assert @p3d <= @q3d
  end

  def test_greater_than_operator
    assert @p3d > Point3D.new(1, 1, 1)
  end

  def test_greater_than_or_equal_operator
    assert @p3d >= @r3d
    assert @p3d >= @q3d
  end

  def test_to_s_method
    assert_equal "(#{@p3d.x}, #{@p3d.y}, #{@p3d.z})", @p3d.to_s
  end

  def test_add_mutator_method
    p3d = @p3d.dup
    @p3d.add!(@q3d)
    assert_equal p3d + @q3d, @p3d
  end

  def test_add_nonmutator_method_same_as_plus_operator
    assert_equal @p3d + @q3d, @p3d.add(@q3d)
  end

  def test_class_method_sum
    assert_equal Point3D.new(5, 3, 4), Point3D.sum(@p3d, @q3d, @r3d)
  end

  def test_class_method_report
    n = 3; avgX = 5.to_f/n; avgY = 3.to_f/n; avgZ = 4.to_f/n
    exp = <<REPORT
Number of points created: #{n}
Average X coordinate: #{avgX}
Average Y coordinate: #{avgY}
Average Z coordinate: #{avgZ}
REPORT
    assert_output(exp) do
      Point3D.report
    end
  end

end
