require File.expand_path('../test_helpers', __FILE__)

class TestEnumerables < MiniTest::Unit::TestCase

  def setup
    @ary0 = ["zero", "one", "two"]
    @hash = { :zero => 0, :one => 1, :two => 2 }
    @ary1 = [1, 3, 5, 7, 9]
    @ary2 = [2, 4, 6, 8, 10]
    @ary3 = (@ary1 + @ary2).sort
  end

  def test_all_method_without_block
    assert @ary1.all?, "should pass as there is no nil or false value in the array (equal to @ary1.all? { |obj| obj }"
  end

  def test_all_method
    assert @ary1.all? { |e| e % 2 == 1 }
  end

  def test_any_method_without_block
    ary = [nil, false]
    assert !ary.any?, "should pass as all values are false and nil (equal to ary.any? { |obj| obj }"
  end

  def test_any_method
    assert @ary1.any? { |e| e < 3 }, "there should be at least one element that is less than three"
  end

  def test_chunk_method
    res = []
    @ary1.chunk { |e| e < 5 }.each { |less, elems| res << [less, elems] }
    assert_equal [[true, [1, 3]], [false, [5, 7, 9]]], res, "should separate the array elements on the chunk block condition"
  end

  def test_chunk_method2
    res = []
    @ary2.chunk { |e| e % 3 }.each { |mod, elems| res << [mod, elems] }
    assert_equal [[2, [2]], [1, [4]], [0, [6]], [2, [8]], [1, [10]]], res, "should separte array elements on the chunk block modulo return value"
  end

  def test_collect_or_map_method
    assert_equal @ary2, @ary1.collect { |e| e + 1 }, "should be return an array with each element incremented by 1"
  end

  def test_collect_concat_or_flat_map_method
    assert_equal [1, 3, 5, 7, 9, 2, 4, 6, 8, 10], ([@ary1] << @ary2).flat_map { |i| i }, "should return the flatten array"
  end

  def test_count_method_without_arguments
    assert_equal 5, @ary1.count, "should be equal to the size of the enumerable"
  end

  def test_count_method_with_an_argument
    assert_equal 1, @ary1.count(5), "should be equal to the amount of times the parameter passed exists within the array"
  end

  def test_count_method_with_a_block
    assert_equal 3, @ary1.count { |i| i > 3 }, "should count the amount of elements inside the array that are greater than 3"
  end

  def test_cycle_method
    res = []
    @ary1.cycle(2) { |i| res << i }
    assert_equal [1, 3, 5, 7, 9, 1, 3, 5, 7, 9], res, "should sequentially assign res with the elements of @ary1 two times"
  end

  def test_detect_or_find_method
    assert_equal 3, @ary1.find {|i| i % 3 == 0 }, "should return the first element which is dividable by 3"
  end

  def test_drop_method
    assert_equal [7, 9], @ary1.drop(3), "should return a shallow copy of the array without the first 3 elements"
  end

  def test_drop_while_method
    assert_equal [7, 9], @ary1.drop_while { |i| i < 7 }, "should return a shallow copy of the array without the elements on which the block condition returned true"
  end

  def test_drop_each_cons_method
    res = []
    @ary1.each_cons(3) { |sub| res << sub }
    assert_equal [[1, 3, 5], [3, 5, 7], [5, 7, 9]], res, "should return subsets of 3 consecutive elements from the array"
  end

  def test_each_slice_method
    res = []
    @ary1.each_slice(2) { |a| res << a }
    assert_equal [[1, 3], [5, 7], [9]], res, "should assign res with an array of subsets of two elements each from the array"
  end

  def test_each_with_index_method
    hash = Hash.new
    @ary0.each_with_index { |item, index| hash[item.to_sym] = index }
    assert_equal @hash, hash, "should contruct a hash with the indices as values"
  end

  def test_each_with_object_method
    res = []
    assert_equal @ary2, @ary1.each_with_object(res) { |i, a| a << i + 1}, "should return the argument array apended with the elements of the @ary1 incremented by one"
  end

  def test_find_index_method
    assert_equal 2, @ary1.find_index(5), "should be equal to the second position of the array"
  end

  def test_find_index_method_with_block
    assert_equal 3, @ary1.find_index { |i| i > 5 && i < 8 }, "should be equal to index 3 as this is the position of the value 7"
  end

  def test_first_method
    assert_equal 2, @ary2.first, "should be equal to the first element of the array"
  end

  def test_select_or_find_all_method
    assert_equal [5, 7, 9], @ary1.select { |e| e > 3 }
  end

  def test_reject_method
    assert_equal [5, 7, 9], @ary1.reject { |e| e <= 3 }
  end

  def test_inject_or_reduce_method_without_a_block
    assert_equal 25, @ary1.reduce(:+)
  end

  def test_inject_or_reduce_method_without_a_block_with_initial_value
    assert_equal 30, @ary1.reduce(5, :+)
  end

  def test_inject_or_reduce_method_as_accumulator
    assert_equal 25, @ary1.inject { |sum, e| sum + e }
  end

  def test_inject_or_reduce_method_as_accumulator_with_initial_value
    assert_equal 30, @ary1.inject(5) { |sum, e| sum + e }
  end

  def test_inject_or_reduce_method_as_comparator
    assert_equal 10, @ary2.inject(0) { |max, e| max = (max < e) ? e : max }
  end



end