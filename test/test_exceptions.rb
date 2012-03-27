require File.expand_path('../test_helpers', __FILE__)

class TestExceptions < MiniTest::Unit::TestCase

  def test_line_number
    assert_equal 6, __LINE__
  end

  def test_file_name
    assert_equal "test_exceptions.rb", __FILE__.gsub(/.*test\//, '')
  end

  def test_method_name
    assert_equal :test_method_name, __method__
  end

  def test_creating_exceptions1
    assert_raises(RuntimeError) { raise "bad argument" }
  end

  def test_creating_exceptions2
    assert_raises(ArgumentError) { raise ArgumentError.new("bad argument")}
  end

  def test_creating_exceptions3
    i = -1
    assert_raises(ArgumentError) {
      raise ArgumentError.new("argument should be positive") if i < 0
    }
  end

  def test_creating_exceptions4
    assert_raises(ZeroDivisionError) {
      res = 1 / 0
      puts res
    }
  end

  def test_handling_exceptions1
    begin
    res = 1 / 0
    puts res
    rescue ZeroDivisionError => e
      assert_equal "divided by 0", e.message
      assert_equal ZeroDivisionError, e.class
    end
  end

  def test_handling_exceptions2
    begin
      raise ArgumentError
    rescue StandardError, ArgumentError => e
      assert_equal ArgumentError, e.class
    end
  end

  def test_handling_exceptions_with_multiple_rescue_classes
    assert_raises(StopIteration) {
      begin
        raise StopIteration.new("no more elements")
      rescue KeyError => ke
        puts "This test should not print #{ke.class}: #{ke.message}"
      rescue NameError => ne
        puts "This text should not print #{ne.class}: #{ne.message}"
      end
    }
  end

  def test_handling_exceptions3
    begin
      raise StopIteration.new("no more elements")
    rescue StandardError
      assert_equal StopIteration, $!.class, "should rescue subclasses of #{$!.class}"
    end
  end

  def test_rescue_with_the_else_clause
    flow = []
    begin
      flow << 1
      raise ArgumentError.new("bad argument") if false
      flow << 2
    rescue ArgumentError
      flow << 3
    else
      flow << 4
    end
    assert_equal [1, 2, 4], flow, "the else clause should run when no exception is raised"
  end

  def test_rescue_with_else_clause_after_unrescued_exception
    flow = []
    begin
      flow << 1
      raise ArgumentError.new("bad argument") if false
      flow << 2
    rescue NoMethodError
      flow << 3
    else
      flow << 4
    end
    assert_equal [1, 2, 4], flow, "the else clause should run when no exception is rescued"
  end

  def test_rescue_with_ensure_clause_when_exception_occurs
    flow = []
    begin
      flow << 1
      raise ArgumentError.new("bad argument") if true
      flow << 2
    rescue ArgumentError
      flow << 3
    else
      flow << 4
    ensure
      flow << 5
    end
    assert_equal [1, 3, 5], flow, "the ensure clause should run when an exception occurs"
  end

  def test_rescue_with_ensure_clause_when_exception_does_not_occur
    flow = []
    begin
      flow << 1
      raise ArgumentError.new("bad argument") if false
      flow << 2
    rescue ArgumentError
      flow << 3
    else
      flow << 4
    ensure
      flow << 5
    end
    assert_equal [1, 2, 4, 5], flow, "the ensure clause should also run when an exception does not occur"
  end

end
