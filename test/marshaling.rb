# *-* encoding: utf-8 *-*
require 'minitest/autorun'
require 'minitest/pride'
require './lib/person.rb'

class TestMarshaling < MiniTest::Unit::TestCase

  FILE_NAME = "./tmp/objects.log"

  def setup
    @str = "object"
    @fixnum = 1
    @float = 1.0
    @p = Person.new("João", "Soares")
    @f = File.new(FILE_NAME, "w")
    Marshal.dump @str, @f
    Marshal.dump @fixnum, @f
    Marshal.dump @float, @f
    Marshal.dump @p, @f
    @f.close
    @mf = File.open(FILE_NAME, "r+")
    @mstr = Marshal.load @mf
    @mfixnum = Marshal.load @mf
    @mfloat = Marshal.load @mf
    @mp = Marshal.load @mf
    @mf.close
  end

  def test_string_marshaling
    assert_equal @str, @mstr, "Should be equal before and after marshaling"
  end

  def test_fixnum_marshaling
    assert_equal @fixnum, @mfixnum, "Should be equal before and after marshaling"
  end

  def test_float_marshaling
    assert_equal @float, @mfloat, "Should be equal before and after marshaling"
  end

  def test_custom_object_marshaling
    assert_equal @p, @mp, "Should be equal before and after marshaling"
  end

end
