# *-* encoding: utf-8 *-*
require 'test/unit'
require './lib/person.rb'
require './lib/customer.rb'

class TestObjects < Test::Unit::TestCase

	def setup
		@obj1 = "object"
		@obj2 = @obj3 = "object"
		@tobj = "object".taint
		@fixnum1 = 1
		@fixnum2 = 1
		@float1 = 1.0
		@p = Person.new("João", "Soares")
		@q = Person.new("João", "Soares")
		@tp = Person.new("João", "Soares").taint
	end

	def test_object_identity
		assert_equal @obj1.object_id, @obj1.__id__, "Should be the same id"
		assert_equal @obj2.object_id, @obj3.object_id, "Should be the same object"
		assert @obj2.equal?(@obj3), "Should be equal as both variables point to the same object"
	end

	def test_string_objects_equality
		assert_equal @obj1, @obj2, "Should be equal as both have the same content"
		assert @obj1.eql?(@obj2), "Should be as both have the same content and are of the same type"
		assert !(@obj1.equal?(@obj2)), "Should be different objects"
		assert @obj2.equal?(@obj3), "Should be the same object"
	end

	def test_numeric_objects_equality
		assert_equal @fixnum1, @float1, "Should be equal as both have the same content and type is not checked"
		assert !(@fixnum1.eql? @float1), "Should not be eql? since they have different types"
		assert @fixnum1.eql?(@fixnum2), "Should be equal in content and type"
	end

	def test_custom_objects_equality
		assert_equal @p, @q, "Should be equal in content as defined in Person#=="
		assert @p.eql?(@q), "Should be equal in content and type as defined in Person#eql?"
	end

	def test_tainted_objects_equality
		assert_equal @obj1, @tobj, "Should be equal in content"
		assert @obj1.eql?(@tobj), "Should be equal in content and type"
		assert !(@obj1.equal? @tobj), "Should be different objects"
	end

	def test_custom_tainted_objects_equality
		assert_equal @p, @tp, "Should be equal in content"
		assert @p.eql?(@tp), "Should be equal in content and type"
		assert !(@p.equal? @tp), "Should be different objects"
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

	def test_object_class
		assert_equal @obj1.class, String, "Should be of the class String"
		assert_equal @obj1.class, @obj2.class, "Should be of the same class"
		assert @obj1.instance_of?(String), "Should be true as @obj1 is a String"
	end

	def test_object_type
		assert !@fixnum1.instance_of?(Numeric), "Should be false as instance_of? does not check inheritance"
		assert @fixnum1.is_a?(Numeric), "Should be true as is_a? checks for inheritance"
		assert @fixnum1.kind_of?(Object), "Should be true, kind_of is an alias for is_a?"
		assert Numeric === @fixnum1, "Should be true as === is defined in class Class as the is_a? method"
	end

	def test_object_methods
		assert @fixnum1.respond_to?(:to_s), "Should respond to to_s since Fixnum implements that method"
	end

	def test_string_tainted_object
		assert @tobj.tainted?, "Should be tainted"
		assert @tobj.upcase.tainted?, "Should be tainted"
	end

	def test_custom_tainted_object
		assert @tp.tainted?, "Should be tainted"
		assert @tp.to_s.tainted?, "Should be tainted, but requires overriding the taint method"
	end

end