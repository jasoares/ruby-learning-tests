require File.expand_path('../test_helpers', __FILE__)
require 'person'
require 'customer'

class TestObjects < MiniTest::Unit::TestCase

	def setup
		@str1 = "object"
		@fstr = @str1.clone.freeze
		@str2 = @str3 = "object"
		@tstr = "object".taint
		@dobj = @str1.dup
		@fixnum1 = 1
		@fixnum2 = 1
		@float1 = 1.0
		@p = Person.new
		@cp = @p.clone
		@fp = @p.clone.freeze
		@tp = @p.clone.taint
		@dp = @p.dup
		@dtp = @tp.dup
		@ctp = @tp.clone
		@dfp = @fp.dup
		@cfp = @fp.clone
	end

	def test_object_identity
		assert_equal @str1.object_id, @str1.__id__, "Should be the same id"
		assert_equal @str2.object_id, @str3.object_id, "Should be the same object"
		assert_same @str2, @str3, "Should be equal as both variables point to the same object"
	end

	def test_string_objects_equality
		assert_equal @str1, @str2, "Should be equal as both have the same content"
		assert @str1.eql?(@str2), "Should be as both have the same content and are of the same type"
		assert !(@str1.equal?(@str2)), "Should be different objects"
		assert @str2.equal?(@str3), "Should be the same object"
	end

	def test_numeric_objects_equality
		assert_equal @fixnum1, @float1, "Should be equal as both have the same content and type is not checked"
		assert !(@fixnum1.eql? @float1), "Should not be eql? since they have different types"
		assert @fixnum1.eql?(@fixnum2), "Should be equal in content and type"
	end

	def test_custom_objects_equality
		assert_equal @p, @cp, "Should be equal in content as defined in Person#=="
		assert @p.eql?(@cp), "Should be equal in content and type as defined in Person#eql?"
	end

	def test_tainted_objects_equality
		assert_equal @str1, @tstr, "Should be equal in content"
		assert @str1.eql?(@tstr), "Should be equal in content and type"
		refute_same @str1, @tstr, "Should be different objects"
	end

	def test_custom_tainted_objects_equality
		assert_equal @p, @tp, "Should be equal in content"
		assert @p.eql?(@tp), "Should be equal in content and type"
		refute_same @p, @tp, "Should be different objects"
	end

	def test_implicit_conversion
		# The below example is also valid for to_i and to_int, to_a and to_ary as it is for to_s and to_str
		assert_equal "#{@p.fname} #{@p.lname}", "" + @p, "Should be equal as the + operator calls the method to_str implicitly on the right hand operand"
	end

	def test_explicit_conversion
		# While implicit conversions call for the to_*** methods(to_ary, to_int, to_str), explicit conversions like
		# string interpolation call for the to_* methods(to_a, to_i and to_s)
		assert_equal @p.to_s, "#{@p}", "Should be equal since string interpolation calls the to_s method"
		assert_equal "#{@p.fname} #{@p.lname}", @p.to_str, "Should be equal"
	end

	def test_object_conversion_functions
		# These functions call the to_*** methods(to_ary, to_int, to_str) and only if not
		# defined they try to call the to_* methods(to_a, to_i, to_s) on their argument
		assert_equal "#{@p.fname} #{@p.lname}", String(@p), "Should be equal to the result of @p.to_str"
		assert_equal [@p.fname, @p.lname], Array(@p), "Should be equal to the result of @p.to_ary"
		assert_equal @fixnum1.to_s, String(@fixnum1), "Should be equal to the result of @fixnum1.to_s"
	end

	def test_object_boolean_comparation
		refute_nil @fixnum1, "Should be different"
		refute_equal @fixnum1, false, "Should be different"
		refute_nil @p, "Should be different"
		refute_equal @p, false, "Should be different"
	end

	def test_object_implicit_boolean_conversion
		assert !nil, "nil should be read as false"
		assert @fixnum1, "Any object that is neither not nil neither false should be considered true"
		assert @p, "Should be read as true since @p is neither nil nor false"
	end

	def test_object_class
		assert_equal @str1.class, String, "Should be of the class String"
		assert_equal @str1.class, @str2.class, "Should be of the same class"
		assert @str1.instance_of?(String), "Should be true as @str1 is a String"
	end

	def test_object_type
		assert !@fixnum1.instance_of?(Numeric), "Should be false as instance_of? does not check inheritance"
		assert_kind_of Numeric, @fixnum1, "Should be true as kind_of? checks for inheritance"
		assert_kind_of Object, @fixnum1, "Should be true, kind_of is an alias for is_a?"
		assert Numeric === @fixnum1, "Should be true as === is defined in class Class as the is_a? method"
	end

	def test_object_methods
		assert @fixnum1.respond_to?(:to_s), "Should respond to to_s since Fixnum implements that method"
	end

	def test_frozen_objects
		assert_equal @str1.upcase, @str1.upcase!, "Should alter the string in place since it is not frozen"
		assert_raises(RuntimeError) { @fstr.upcase! }
		assert_equal @p.fname = "Jane", @p.fname, 'Should assign @p.fname with "Jane" since it is not frozen'
		assert_raises(RuntimeError) { @fp.fname = "Jane" }
	end

	def test_string_tainted_object
		assert @tstr.tainted?, "Should be tainted"
		assert @tstr.upcase.tainted?, "Should be tainted"
	end

	def test_custom_tainted_object
		assert @tp.tainted?, "Should be tainted"
		assert @tp.to_s.tainted?, "Should be tainted, but requires overriding the taint method"
	end

	def test_object_duplicates
		assert_equal @str1, @dobj, "Should be equal before and after the duplicate"
		assert_equal @p, @dp, "Should be equal, see the initialize_copy implementation of the class Person"
	end

	def test_duplicated_tainted_object
		assert @dtp.tainted?, "Should be tainted"
	end

	def test_cloned_tainted_object
		assert @ctp.tainted?, "Should be tainted"
	end

	def test_duplicated_frozen_object
		assert !@dfp.frozen?, "Should not be frozen"
	end

	def test_cloned_frozen_object
		assert @cfp.frozen?, "Should be frozen"
	end

end
