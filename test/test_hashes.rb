require 'test/unit'

class TestHashes < Test::Unit::TestCase

  def test_hash_creation
    # Note that single or double quotes, makes no difference
    # the same way as curly braces or square brackets
    h = Hash[ :one => 1, :two => 2, :three => "three", :four => 4.0 ]
    assert_equal({:one => 1, :two => 2, :three => 'three', :four => 4.0 }, h,
    "Should be equal to { :one => 1, :two => 2, :three => \"three\", :four => 4.0 }")

    h = Hash.new
    h[:one] = 1; h[:two] = 2; h[:three] = 'three'; h[:four] = 4.0
    assert_equal({:one => 1, :two => 2, :three => 'three', :four => 4.0 }, h,
    "Should be equal to { :one => 1, :two => 2, :three => \"three\", :four => 4.0 }")

    h = { :one => 1, :two => 2, :three => "three", :four => 4.0 }
    assert_equal({:one => 1, :two => 2, :three => 'three', :four => 4.0 }, h,
    "Should be equal to { :one => 1, :two => 2, :three => \"three\", :four => 4.0 }")
  end

  def test_syntax_changes_for_versions_later_than_1_9_x
    # New syntax since version 1.9.x
    # Note that there may not be any space between the hash key identifier and the colon
    code = '{ two: 2, three: 3 }'
    if RUBY_VERSION >= "1.9.0"
      assert RUBY_VERSION > "1.9.0", "Version should be later than 1.9"
      h = eval(code)
      assert_equal({ :two => 2, :three => 3 }, h, "Should be equal to #{code}")
    end
  end

  def test_syntax_changes_for_versions_prior_to_1_9_x
    # Old Syntax deprecated since version 1.9
    code = '{:one, 1, :two, 2 }'
    if RUBY_VERSION < "1.9.0"
      assert RUBY_VERSION < "1.9.0", "Version should be prior to 1.9"
      h = eval(code)
      assert_equal({ :one => 1, :two => 2 }, h, "Should be equal to #{code}")
    end
  end

  def test_syntax_common_to_both_before_and_after_version_1_9_x
    # Common Syntax valid in both versions
    # Note the trailing comma doesn't break the test, it is ignored
    h = { :one => 1, :two => 2, }
    assert_equal({:one => 1, :two => 2 }, h, "Should be equal to { :one => 1, :two => 2 }")
  end

  def test_hash_equality
    empty_h1 = Hash.new; empty_h2 = {}
    assert_equal empty_h2, empty_h1, "Should be equal since they are both empty"

    h1 = { :one => 1, :two => 2 }; h2 = { :two => 2, :one => 1 }
    assert_equal h1, h2, "Should be equal since they contain the same content"
  end

end