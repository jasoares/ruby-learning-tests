require File.expand_path('../test_helpers', __FILE__)

class TestBlocks < MiniTest::Unit::TestCase

  def setup
    @array1 = [1, 2, 3, 4, 5]
  end

  def test_block_syntax1
    a = @array1.map do |e|
      e + 1
    end
    assert_equal [2, 3, 4, 5, 6], a
  end

  def test_block_syntax2
    a = @array1.map { |e| e + 1 }
    assert_equal [2, 3, 4, 5, 6], a
  end

  def test_block_syntax3
    a = @array1.map do |e| e + 1 end
    assert_equal [2, 3, 4, 5, 6], a
  end

  def test_block_return_values1
    a = @array1.sort { |x, y| y - x }
    assert_equal [5, 4, 3, 2, 1], a
  end

  def test_block_return_values2
    a = @array1.select { |e| e > 2 }
    assert_equal [3, 4, 5], a
  end

  def test_block_return_values3
    a = @array1.reduce(0) { |sum, e| sum + e }
    assert_equal 15, a
  end

  def test_block_variable_scope1
    a = []
    @array1.each { |e| a << e }
    assert_equal @array1, a
  end

  def test_block_variable_scope2_ruby_version_1_9_and_above
    a = []
    1.upto(2) do |i|
      4.upto(5) do |i| # ruby version 1.9 shows warning for shadowing variable
        a << i
      end
      a << i
    end
    if(RUBY_VERSION >= "1.9.0")
      assert_equal [4, 5, 1, 4, 5, 2], a
    else
      assert_equal [4, 5, 5, 4, 5, 5], a
    end
  end

end
