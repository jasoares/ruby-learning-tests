require 'test/unit'

class TestLoops < Test::Unit::TestCase

  # while and until loops

  def test_while_loop
    x = 5
    while x > 0 do
      x -= 1
    end
    assert_equal 0, x, "x should end the loop with the value 0"
  end

  def test_while_loop_without_do
    x = 5
    while x > 0
      x -= 1
    end
    assert_equal 0, x, "x should end the loop with the value 0"
  end

  def test_oneline_while_loop
    x = 5
    while x > 0 do x -= 1 end
    assert_equal 0, x, "x should end the loop with the value 0"
  end

  def test_oneline_while_loop_alternative_syntax
    x = 5
    while x > 0; x -= 1 end
    assert_equal 0, x, "x should end the loop with the value 0"
  end

  def test_until_loop
    x = 0
    until x == 5 do
      x += 1
    end
    assert_equal 5, x, "x should end the loop with a value of 5"
  end

  def test_until_loop_without_do
    x = 0
    until x == 5
      x += 1
    end
    assert_equal 5, x, "x should end the loop with a value of 5"
  end

  def test_oneline_until_loop
    x = 0
    until x == 5 do x += 1 end
    assert_equal 5, x, "x should end the loop with a value of 5"
  end

  def test_online_until_loop_alternative_syntax
    x = 0
    until x == 5; x += 1 end
    assert_equal 5, x, "x should end the loop with a value of 5"
  end

  def test_while_loop_as_a_modifier
    x = 5
    x -= 1 while x > 0
    assert_equal 0, x, "x should end the loop with the value 0"
  end

  def test_until_loop_as_a_modifier
    x = [1, 2, 3]
    x.pop until x.empty?
    assert x.empty?, "x should be empty at the end"
  end

  def test_do_while_loop_special_case
    x = 10; y = 1
    begin
      y += 1
    end until x == 10
    assert_equal 2, y, "y should be equal to 2 as the first iteration runs before the condition"
  end

  def test_special_case_do_not_ocur_when_parens_are_used_instead_of_begin_end
    x = 10; y = 1
    (
      y += 1
    ) until x == 10
    assert_equal 1, y, "y should be equal to 1 as the first iteration runs after evaluating the condition"
  end

  # for in loops

  def test_for_in_loop_arrays
    array1 = [1, 2, 3]
    array2 = []
    for element in array1
      array2 << element += 1
    end
    assert_equal [2, 3, 4], array2, "array elements should be incremented by one each"
  end

  def test_for_in_loop_hashes
    hash = { :one => 1, :two => 2, :three => 3 }
    array = []
    for key, value in hash
      array << [key, value]
    end
    assert_equal [[:one, 1], [:two, 2], [:three, 3]], array, "hash should have been copied to the array"
  end

  def test_for_in_loop_return
    hash = { :one => 1, :two => 2, :three => 3 }
    array = []
    var2 = for key, value in hash
      array << [key, value]
    end
    assert_equal hash, var2, "hash should have been copied to the array"
    assert_equal [[:one, 1], [:two, 2], [:three, 3]], array, "hash should have been copied to the array"
  end



end