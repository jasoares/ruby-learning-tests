require 'minitest/autorun'
require 'minitest/pride'

class TestConditionals < MiniTest::Unit::TestCase

  def test_complex_if_elsif_else_expression
    (1..4).each do |x|
      y = 2

      if x == 2
        y += 1
      elsif x < 3
        y -= 1
      elsif x > 3
        y = y
      else
        y = 0
      end

      if x == 2
        assert_equal 3, y, "y should be 3"
      elsif x < 3
        assert_equal 1, y, "y should be 1"
      elsif x > 3
        assert_equal 2, y, "y should be 2"
      else
        assert_equal 0, y, "y should be 0"
      end
    end
  end

  def test_if_elsif_expression_without_else_and_different_syntax
    (1..4).each do |x|
      y = 2

      if x == 2 then y += 1
      elsif x < 3 then y -= 1
      elsif x > 3 then y = y end

      if x == 2 ; assert_equal 3, y, "y should be 3"
      elsif x < 3 ; assert_equal 1, y, "y should be 1"
      elsif x > 3 ; assert_equal 2, y, "y should be 2"
      else assert_equal 2, y, "y should be 2 since no code was run" end
    end
  end

  def test_if_elsif_expression_return_value
    (1..4).each do |x|
      y = 2
      y = if    x == 2 then y + 1
          elsif x <  3 then y - 1
          elsif x >  3 then y
          else              0
          end

      if x == 2 ; assert_equal 3, y, "y should be 3"
      elsif x < 3 ; assert_equal 1, y, "y should be 1"
      elsif x > 3 ; assert_equal 2, y, "y should be 2"
      else assert_equal 0, y, "y should be 0" end
    end
  end

  def test_if_alternative_syntax1
    x = 0; y = 0

    begin
      x += 1
      y += 2
    end if x == 0 and y == 0

    assert x == 1 && y == 2, "x and y should have been defined"
  end

  def test_if_alternative_syntax2
    x = 0; y = 0

    (
      x += 1
      y += 2
    ) if x == 0 && y == 0

    assert x == 1 && y == 2, "x and y should have been defined"
  end

  def test_simple_oneline_if_modifier
    y = "string".upcase if "string".respond_to? :upcase
    assert_equal y, "STRING", 'y should be equal to "STRING since String#respond_to? :upcase"'
  end

  def test_simple_oneline_if_modifier_return_value
    y = ("string".to_a if "string".respond_to? :to_a)
    assert_nil y, "y should be assigned nil as String does not define the method to_a"
  end

  def test_simple_unless_expression
    unless defined? x
      x = 10
    end
    assert_equal 10, x, "x should be defined"
  end

  def test_oneline_unless_expression2
    unless defined? x then x = 10 end
    assert_equal 10, x, "x should be defined"
  end

  def test_unless_modifier
    x = 10 unless x == 0
    assert_equal 10, x, "x should be assigned 10"
  end

  def test_unless_else_expression
    x = 0
    2.times do
      unless x > 0
        x = 1
      else
        x = nil
      end
    end
    assert_nil x, "should be assigned nil at the end"
  end

  def test_case_simple_expression
    x = case
      when x == 1 then "one"
      when x == 2 then "two"
      when x == 3 then "three"
      when x == 4 then "four"
      else "many"
    end
    assert_equal "many", x, 'x should be assigned "many"'
  end

  def test_case_simple_expression_alternative_syntax
    x = 2
    x = case
    when x == 1 || x == 2; "one or two"
    when x == 3, x == 4; "three or four" end
    assert_equal "one or two", x, 'x should be assigned "one or two"'
  end

  def test_case_simple_expression_alternative_syntax2
    x = 2
    x = case x
    when 1, 2; "one or two"
    when 3..6; "three to six" end
    assert_equal "one or two", x, 'x should be assigned "one or two"'
  end

  def test_case_simple_expression_alternative2
    x = true
    assert_equal "boolean",
    case x
      when String; "string"
      when Numeric; "number"
      when TrueClass, FalseClass then "boolean"
      else "other"
    end,
    "should be a boolean"
  end

  def test_case_simple_expression_alternative3
    x = nil
    assert !case x
      when nil, [], "", 0
        false
      else
        true
    end,
    "should be false"
  end

  def test_ternary_operator_conditional
    n = 2
    assert_equal "messages", (n == 1) ? "message" : "messages", "should be messages"
  end

end
