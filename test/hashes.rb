require 'minitest/autorun'
require 'minitest/pride'

class TestHashes < MiniTest::Unit::TestCase

  def setup
    # Note that single or double quotes, makes no difference
    # the same way as curly braces or square brackets
    @h1 = Hash[ :one => 1, :two => 2, :three => "three", :four => 4.0 ]
    @h2 = Hash.new
    @h2[:one] = 1; @h2[:two] = 2; @h2[:three] = 'three'; @h2[:four] = 4.0
    @h3 = { :one => 1, :two => 2, :three => "three", :four => 4.0 }
    
    # Old syntax deprecated since version 1.9
    @old_code = '{:one, 1, :two, 2 }'
    
    # New syntax since version 1.9.x
    # Note that there may not be any space between the hash key identifier and the colon
    @new_code = '{one: 1, two: 2 }'
    if RUBY_VERSION >= "1.9.0"
      @h4 = eval(@new_code)
    else
      @h4 = eval(@old_code)
    end
    
    # Common syntax valid in both versions
    @h5 = { :one => 1, :two => 2 }

    @empty1 = Hash.new; @empty2 = {}
  end

  def test_hash_creation
    assert_equal @h1, @h2, "Should be equal to"
    assert_equal @h2, @h3, "Should be equal"
  end

  def test_syntax_changes_introduced_in_version_1_9_x
    assert_equal @h5, @h4, "Should represent the same hash"
  end

  def test_hash_equality
    assert_equal @empty1, @empty2, "Should be equal since they are both empty"
  end

end
