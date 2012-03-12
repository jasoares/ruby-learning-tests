require 'test/unit'
require './lib/person.rb'

class TestAssignment < Test::Unit::TestCase

  # Ambiguous assignment

  def x
    1
  end

  def test_method_evaluation
    assert_equal 1, x, "Should be equal to method x"
  end

  def test_variable_assignment_not_executed
    x = 0 if false
    assert_nil x, "x should be equal to nil, as the assignment was not executed"
  end

  def test_variable_assignment_executed
    x = 2
    assert_equal 2, x, "Should be equal to the value x variable was assigned to"
  end

  # Parallel Assignment

  def test_parallel_assignment_same_number_of_lvalues_and_rvalues
    x, y, z = 'x', 'y', 'z'
    assert 'x' == x && 'y' == y && 'z' && z, "rvalues should be distributed evenly by the lvalues"
  end

  def test_paralled_assignment_swaping_two_variables
    v = 'v'; w = 'w'; v, w = w, v
    assert 'w' == v && 'v' == w, "The values should be swaped"
  end

  def test_parallel_assignment_one_lvalue_multiple_rvalues_array
    a1 = 1, 2, 3
    assert_equal [1, 2, 3], a1, "Should be assigned all the values as an array"
  end

  def test_parallel_assignment_one_lvalue_with_splat_operator_multiple_rvalues_array
    # @a = 1, 2, 3 can also be expressed with a splat to make things clearer like
    *a2 = 1, 2, 3
    assert_equal [1, 2, 3], a2, "Should be assigned all the values as an array"
  end

  def test_parallel_assignment_one_lvalue_multiple_rvalues_discard
    b, = 1, 2, 3
    assert_equal 1, b, "Should be assigned to the first rvalue, others are discarded"
  end

  def test_parallel_assignment_multiple_lvalues_single_array_rvalue
    @c, @d, @e = [1, 2, 3]
    assert 1 == @c && 2 == @d && 3 == @e, "The array should be split between the lvalues" 
  end

  def test_parallel_assignment_multiple_lvalues_single_array_rvalue_custom_object
    @p = Person.new("John", "Doe")
    @fname, @lname = @p
    assert @fname == @p.fname && @lname == @p.lname, "The object's to_ary method is called to expand the object into two variables"
  end

  def test_parallel_assignment_one_lvalue_one_array_rvalue
    f, = [1, 2, 3] # The comma makes it a parallel assignment
    assert_equal 1, f, "Should be assigned 1 and the others rvalues discarded"
  end

  def test_parallel_assignment_different_numbers_of_lvalues_and_rvalues_nil
    g, h, i = 1, 2
    assert g == 1 && h == 2 && i == nil, "g and h should be assigned to 1 and 2, and i should be assigned nil"
  end

  def test_parallel_assignment_different_numbers_of_lvalues_and_rvalues_discard
    j, k = 1, 2, 3
    assert j == 1 && k == 2, "j and k should be assigned to 1 and 2, and 3 should be discarded"
  end

  def test_parallel_assignment_with_splat_operator_on_rvalues
    l, m, n = 1, *[2, 3]
    assert l == 1 && m == 2 && n == 3, "The splat operator makes the array to be expanded and distributed by the lvalues"
  end

  def test_parallel_assignment_without_splat_operator_on_rvalues
    o, p, q = 1, [2, 3]
    assert o == 1 && p == [2, 3] && q == nil, "The absence of a splat operator makes the array to be assigned to only on lvalue"
  end

  def test_parallel_assignment_with_splat_operator_on_lvalues_case1
    r1, *s1 = 1, 2, 3
    assert r1 == 1 && s1 == [2, 3], "The splat operator assigned all remaning rvalues to that lvalue"
  end

  def test_parallel_assignment_with_splat_operator_on_lvalues_case2
    r2, *s2 = 1, 2
    assert r2 == 1 && s2 == [2], "The splat operator assigned an array with the only left rvalue to that lvalue"
  end

  def test_parallel_assignment_with_splat_operator_on_lvalues_case3
    r3, *s3 = 1
    assert r3 == 1 && s3 == [], "The splat operator assigned an empty array to that lvalue since there were no left rvalues"
  end

  def test_parallel_assignment_with_parens
    a, (b, (c, d)) = [1, [2, [3, 4]]]
    assert a == 1 && b == 2 && c == 3 && d == 4, "For each lvalue should correspond one rvalue in the order they are presented"
  end

end