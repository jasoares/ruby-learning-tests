require File.expand_path('../test_helpers.rb', __FILE__)
require 'point3d'

class TestSampleSubclass < MiniTest::Unit::TestCase

  def setup
    @p3d = Point3D.new(2, 1, 1)
    @q3d = Point3D.new(1, 1, 2)
    @r3d = Point3D.new(2, 1, 1)
  end

  def test_class_instantiation
    assert_equal [2, 1, 1], [@p3d.x, @p3d.y, @p3d.z]
  end



end