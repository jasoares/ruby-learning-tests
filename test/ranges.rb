require 'test/unit'

class TestRanges < Test::Unit::TestCase

  def setup
    @r = 1..5
    @er = 1...5
    @fr = 1.0..5.0
    @sr = 'a'..'d'
    @msr = 'AAA'...'ZZZ'
  end

  def test_range_creation
    assert_equal 1..5, Range.new(1, 5)
    assert_equal 1...8, Range.new(1, 8, true)
    assert_equal 'a'..'z', Range.new('a', 'z')
    assert_equal 'a'...'d', Range.new('a', 'd', true)
  end

  def test_inclusive_range_creation
    assert @r.include? 1
    assert @r.include? 5
    assert @r.include? 3
    assert !(@r.include? 5.1)
  end

  def test_exclusive_range_creation
    assert @er.include? 1
    assert !(@er.include? 5)
    assert @er.include? 2
    assert @er.include? 2.8
    assert !(@er.include? 0.9)
  end

  def test_float_range_creation
    assert @fr.include? 1
    assert @fr.include? 1.0
    assert @fr.include? 2.1
    assert @fr.include? 5.0
    assert !(@fr.include? 5.1)
  end

  def test_string_range_creation
    assert @sr.include? 'a'
    assert @sr.include? 'c'
    assert @sr.include? 'd'
    assert !(@sr.include? 'e')
  end

  def test_method_call_syntax
    # 1..5.to_a # error on endpoint range definition because it expects for a float starting by 3.x
    assert_equal(@r.respond_to?('to_a'), true, "Expected to return true since it was called using parenthesis on the range 1..3")
  end

  def test_availability_of_enumerable_each_method_for_range_types
    assert_equal @r.begin.respond_to?('succ'), true, "FixNum ranges are iterable through the each method since its start point responds to succ"
    assert_equal @fr.begin.respond_to?('succ'), false, "Float ranges are not iterable through the each method since its start point doesn't respond to succ"
  end

  def test_string_range_membership
    assert @msr.include?("ABC"), "Expected to return true since the range includes strings from AAA to ZZZ passing through ABB...ABC...ABD..."
    if RUBY_VERSION >= "1.9"
      # Note that String#member? is an alias of include?
      assert_equal @msr.include?("ABCD"), false, "Expected to return false in 1.9 since ABCD is greater than ABC"
      code = ('@msr.cover? "ABCD"') # code evaluated conditionally since the cover? method doesn't exist prior to version 1.9
      assert_equal eval(code), true, "Expected to be true since when alphabetically sorted AAA < ABCD < ZZZ"
    else # if RUBY_VERSION < "1.9"
      assert @msr.include?("ABCD"), "Expected to be true on ruby 1.8 because is it compared by the string comparator <=>"
    end
  end

  def test_range_equal_operator
    assert @r === 3, "Expected to return true as the range includes the value 3"
    assert !(@er === 5), "Expected to be false as the range is exclusive and does not include the value 5"
    assert @fr === 2.0, "Expected to return true as the range includes the value 2.0"
    assert @fr === 2.5, "Expected to return true as the range is continuous and 2.5 > 1.0 and 2.5 < 5.0"
    assert @sr === 'c', "Expected to return true as the range includes 'c'"
    assert @msr === 'ABC', "Expected to return true as the range includes the value 'ABC'"
  end

end