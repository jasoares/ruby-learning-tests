require File.expand_path('../test_helpers', __FILE__)

class TestControlFlow < MiniTest::Unit::TestCase

  def test_break_statement
    a = []
    1.upto(3) do |i|
      break if i == 2
      a << i
    end
    assert_equal [1], a
  end

  def test_next_statement
    a = []
    1.upto(5) do |i|
      next if i == 3
      a << i
    end
    assert_equal [1, 2, 4, 5], a
  end

  def test_redo_statement
    a = []; i = 0
    while(i < 3)
      a << i
      i += 1
      redo if i == 3
    end
    assert_equal [0, 1, 2, 3], a
  end

  def test_retry_statement
    n = 5
    a = []
    n.times do |i|
      a << i
      if i == 4
        n -=1
        eval("retry") if RUBY_VERSION < "1.9.0"
      end
    end
    if RUBY_VERSION < "1.9.0"
      assert_equal [0, 1, 2, 3, 4, 0, 1, 2, 3], a
    else
      assert_equal [0, 1, 2, 3, 4], a
    end
  end

end