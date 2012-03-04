require 'test/unit'

class TestSymbols < Test::Unit::TestCase

  def test_symbol_creation_syntax_variants
    assert_equal :symbol, :"symbol", "Should return true since they represent the same symbol"
    assert_equal :'symbol with spaces', :"symbol with spaces", "Should return true since they represent the same symbol with spaces in it"
    s = "symbol"
    sym = :"#{s}"
    assert_equal sym, :symbol, "Should return true since both represent the same symbol but this time one of them is dynamically created"
    assert_equal %s["], :"\"", "Should return true since both represent the weird symbol :\""
    assert_equal %s["], :'"', "Should return true since both represent the weird symbol :\""
  end

  

end