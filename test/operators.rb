require 'test/unit'

class TestOperators < Test::Unit::TestCase

  # Unary Plus Operator

  def test_unary_plus_operator
    a = +1; b = 1
    assert_equal a, b, "The unary plus operator has no effected on numeric operands"
  end

  def test_unary_plus_operator_with_negative_operand
    a = -1; b = +(-1)
    assert_equal a, b, "The unary plus operator has no effected on numeric operands"
  end

  # Unary minus Operator

  def test_unary_minus_operator
    a = -1; b = -(+1)
    assert_equal a, b, "The unary minus operator changes the sign of its numeric operand"
  end

  # Exponentiation operator

  def test_exponentiation_operator
    a = 2; b = 3
    assert_equal 8, a**b, "Should be equal to 2 raised to the power of 3"
  end

  def test_exponentiation_operator_with_negative_power
    a = 2; b = -2
    assert_equal Rational(1, 4), a**b, "Should be equal to 1 divided by 2 raised to the power of 2"
  end

  def test_exponentiation_operator_with_righ_associative_operation
    a = 2; b = 2; c = 3
    assert_equal 256, a**b**c, "Should be equal to 2 raised to the power of 2**3"
  end

  def test_exponentiation_operator_with_rational_power
    a = 27; b = Rational(1, 3)
    assert_equal 3, a**b, "Should be equal to the cube root of a"
  end

  # Boolean operators details

  def test_boolean_and_operator_with_a_true_value_in_the_lefthand_operand
    x = 1; y = 2
    assert_equal y, x && y, "Should be equal to y since x an y are true"
    x = 'a'; y = nil
    assert_equal y, x && y, "Should be equal to y since x is *a* true value"
  end

  def test_boolean_and_operator_with_a_false_value_in_the_lefthand_operand
    x = nil; y = 2
    assert_nil x && y, "Should be equal to x since x is *a* false value"
    x = false; y = 3
    assert !(x && y), "Should be equal to x since x is *the* false value"
    x = nil; y = false
    assert_nil x && y, "Should be equal to x since x is *a* false value"
  end

  def test_boolean_or_operator_with_a_false_value_in_the_lefthand_operand
    x = nil; y = 2
    assert_equal y, x || y, "Should be equal to y since x is *a* false value"
    x = 3; y = 3
    assert_equal x, x || y, "Should be equal to x since x is *a* true value"
  end

  def test_boolean_or_operator_with_a_true_value_in_the_lefthand_operand
    x = 1; y = nil
    assert_equal x, x || y, "Should return x since x is *a* true value"
    x = true; y = 3
    assert x || y, "Should return x since x is *a* true value"
  end

  def test_boolean_or_return_value_with_actual_true_or_false_values
    x = 3; y = -2; a = nil
    assert x > 3 || y < 1 || a == nil, "Should return true since it is the value return by the second condition"
  end

  def test_boolean_or_return_value_with_multiple_expressions_and_literals
    x = 3; y = -2; a = nil
    assert_nil x > 3 || y > 1 || a, "Should return the value of the last literal"
  end

  def test_boolean_and_return_value_with_actual_true_or_false_values
    x = 3; y = -2; a = nil
    assert x < 5 && y < 1 && a == nil, "Should return true"
  end

  def test_boolean_and_return_value_with_multiple_expressions_and_literals
    x = 3; y = -2; a = nil
    assert_nil x <= 3 && y == -2 && a, "Should return the true value of the last condition"
  end

  def test_boolean_or_operator_with_multiple_expressions
    x = 3; y = -2; a = []
    x < 5 || y > 2 || a = [1, 2, 3]
    assert_equal [], a, "Should be empty because it is never executed"
    x < 2 || y > 1 || a = [1, 2, 3]
    assert_equal [1, 2, 3], a, "Shoulb have been assigned since all previous conditions are false"
  end

  def test_boolean_and_operator_with_multiple_expressions
    x = 3; y = -2; a = []
    x < 5 && y < 2 && a = [1, 2, 3]
    assert_equal [1, 2, 3], a, "Should have been assigned since all previous conditions are true"
    x > 2 && y > 1 && a = [1, 2, 3]
    assert_equal [1, 2, 3], a, "Shoulb be empty since it was never executed due to a previous false condition"
  end

  def test_common_use_of_or_operator_for_assigning_not_nil_values
    x = nil; y = nil; z = 3
    a ||= x || y || z
    assert_equal a, z, "a should have been assigned z"
  end

  def test_boolean_not_operator
    assert !nil, "Should be true"
  end

  def test_boolean_operator_english_alternatives
    x = 2; y = 3
    if x > 0 and y > 0 and not defined? d then d = Math.sqrt(x*x + y*y) end
    assert_equal Math.sqrt(x*x + y*y), d, "d should have been calculated"
  end

  def test_boolean_operator_english_alternatives_precedence
    x = 1; y = 2
    assert_equal x, x || y && nil, "Should return x since && is performed first"
    assert_nil((x or y and nil), "Should be nil since they have the same precedence and are performed from left to right")
  end

  def test_boolean_operator_english_alternatives_real_world_use
    arg = ""
    str = arg and str.empty? and str << "empty"
    assert_equal "empty", str, "Should have been assigned \"empty\" because it was empty"
  end

  # Other simple operators

  def test_ternary_operator
    x = 3; y = 5; z = 7
    max = x>y ? x>z ? x : z : y>z ? y : z
    assert_equal z, max, "the max value should be equal to z"
  end

end
