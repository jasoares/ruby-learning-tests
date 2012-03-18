require File.expand_path('../test_helpers', __FILE__)
require 'benchmark'

class TestSymbols < MiniTest::Unit::TestCase

  def test_symbol_creation_syntax_variants
    assert_equal :symbol, :"symbol", "Should return true since they represent the same symbol"
    assert_equal :'symbol with spaces', :"symbol with spaces", "Should return true since they represent the same symbol with spaces in it"
    s = "symbol"
    sym = :"#{s}"
    assert_equal sym, :symbol, "Should return true since both represent the same symbol but this time one of them is dynamically created"
    assert_equal %s["], :"\"", "Should return true since both represent the weird symbol :\""
    assert_equal %s["], :'"', "Should return true since both represent the weird symbol :\""
  end

  def test_convertion_symbol_to_string
    sym = :string
    assert_equal "string", sym.to_s, "Expected to convert symbol to string"
    assert_equal "string", sym.id2name, "Expected to convert symbol to string"
  end

  def test_convertion_string_to_symbol
    str = "symbol"
    assert_equal :symbol, str.to_sym, "Expected to convert string to symbol"
    assert_equal :symbol, str.intern, "Expected to convert string to symbol"
  end

  def test_symbol_comparison_against_string_comparison_time
    str_time = Benchmark.measure do
      "string" == "string"
    end
    sym_time = Benchmark.measure do
      :string == :string
    end
    assert str_time.real > sym_time.real
  end
end
