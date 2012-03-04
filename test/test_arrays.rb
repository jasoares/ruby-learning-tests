require 'test/unit'

class TestArrays < Test::Unit::TestCase

  def test_creating_arrays
    empty_array = Array.new
    assert_equal [].class, empty_array.class
    assert_equal 0, empty_array.size
    assert_equal empty_array, Array.new(empty_array), "Should be a copy of empty_array"
    assert_equal Array.new(3) {|i| i + 1 }, [1, 2, 3], "Should be equal to [1, 2, 3]"
    assert_equal Array.new(2, '.'), ['.', '.'], "Should be equal to ['.', '.']"
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array, "Should be an empty array"

    array[0] = 1
    assert_equal [1], array, "Should be [1]"

    array[1] = 2
    assert_equal [1, 2], array, "Should be [1, 2]"

    array << 333
    assert_equal [1, 2, 333], array, "Should be [1, 2, 333]"
  end

  def test_array_square_bracket_method
    a = ['a', 'b', 'c', 'd', 'e', 'f']
    assert_equal 'a', a[0], "Should have been 'a'"
    assert_equal a[a.length - 2], a[-2], "Should have been the same element"
    assert_equal a[-a.size], a[0], "Should have been 'a'"
  end

  def test_array_square_bracket_assign_method
    a = [1, 'b', 'c', 'D', 5, 6.0]
    a[0] = "one"
    assert_equal ["one", 'b', 'c', 'D', 5, 6.0], a, "Should have been [\"one\", 'b', 'c', 'D', 5, 6.0]"
    a[-1] = 1..16
    assert_equal ["one", 'b', 'c', 'D', 5, 1..16], a, "Should have been [\"one\", 'b', 'c', 'D', 5, 1..16]"
    a[7] = 64
    assert_equal ["one", 'b', 'c', 'D', 5, 1..16, nil, 64], a, "Should have been [\"one\", 'b', 'c', 'D', 5, 1..16, nil, 64]"
  end

  def test_array_square_bracket_deletions
    a = ["one", 'b', 'c', 'D', 5, 1..16, nil, 64]
    a[-2, 2] = []
    assert_equal ["one", 'b', 'c', 'D', 5, 1..16], a, "Should be [\"one\", 'b', 'c', 'D', 5, 1..16]"
    a[1...3] = ['B', 'C']
    assert_equal ["one", 'B', 'C', 'D', 5, 1..16], a, "Should be [\"one\", 'B', 'D', 'D', 5, 1..16]"
    a[0, 1] = []
    assert_equal ['B', 'C', 'D', 5, 1..16], a, "Should be ['B', 'C', 'D', 5, 1..16]"
    a[-1, 1] = nil
    if RUBY_VERSION > "1.9"
      # Since version 1.9 the nil assignment no longer deletes the item
      assert_equal ['B', 'C', 'D', 5, nil], a, "Should be ['B', 'C', 'D', 5, nil]"
    else
      # Prior to 1.9 a nil assignment used to delete the item
      assert_equal ['B', 'C', 'D', 5], a, "Should be ['B', 'C', 'D', 5]"
    end
  end

  def test_array_square_bracket_insertions
    a = ['B', 'C', 'D', 5, nil]
    a[0, 0] = [1, 2, 3]
    assert_equal [1, 2, 3, 'B', 'C', 'D', 5, nil], a, "Should be [1, 2, 3, 'B', 'D', 'D', 5, nil]"
  end

  def test_array_equality
    a = [1, 2, 3]
    b = [2, 3, 1]
    assert_not_equal a, b, "Should have been different"
    assert_not_equal a, [[1, 2, 3]], "Should have been different"
    assert_not_equal a, [[1], [2], [3]], "Should have been different"
  end

  def test_array_arithmetic_operators
    a = [1, 2, 3]
    b = [3, 4, 5]
    assert_equal [1, 2, 3, 3, 4, 5], a + b, "Should have been [1, 2, 3, 3, 4, 5]"
    assert_equal [3, 4, 5, 1, 2, 3], b + a, "Should have been [3, 4, 5, 1, 2, 3]"
    assert_equal [1, 2], a - b, "Should have been [1, 2]"
    assert_equal [4, 5], b - a, "Should have been [4, 5]"
  end

  def test_array_boolean_operators
    a = [1, 1, 2, 2, 3, 3, 4]
    b = [5, 5, 4, 4, 3, 3, 2]
    assert_equal [1, 2, 3, 4, 5], a | b, "Should have been [1, 2, 3, 4, 5]"
    assert_equal [5, 4, 3, 2, 1], b | a, "Should have been [5, 4, 3, 2, 1]"
    assert_equal [2, 3, 4], a & b, "Should have been [2, 3, 4]"
    assert_equal [4, 3, 2], b & a, "Should have been [4, 3, 2]"
  end

  def test_array_each
    alphabet = ('A'..'C').to_a
    i = 0
    alphabet.each do |letter|
      assert alphabet[i] == letter, "Should be #{alphabet[i]} for i = #{i}"
      i += 1
    end
  end
end