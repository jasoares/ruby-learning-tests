require 'test/unit'

class TestRanges < Test::Unit::TestCase

  def test_inclusive_range_creation
    r = 1..5
    assert r.include? 1
    assert r.include? 5
    assert r.include? 3
    assert !(r.include? 5.1)
  end

  def test_exclusive_range_creation
    er = 1...5
    assert er.include? 1
    assert !(er.include? 5)
    assert er.include? 2
    assert er.include? 2.8
    assert !(er.include? 0.9)
  end

  def test_float_range_creation
    fr = 1.0..5.0
    assert fr.include? 1
    assert fr.include? 1.0
    assert fr.include? 2.1
    assert fr.include? 5.0
    assert !(fr.include? 5.1)
  end

  def test_string_range_creation
    sr = 'a'..'d'
    assert sr.include? 'a'
    assert sr.include? 'c'
    assert sr.include? 'd'
    assert !(sr.include? 'e')
  end
end