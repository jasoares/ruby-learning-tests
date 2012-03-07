require 'test/unit'

class TestObjects < Test::Unit::TestCase

	def setup
		@obj1 = "object"
		@obj2 = @obj3 = "object"
	end

	def test_object_identity
		assert @obj1.eql?(@obj2), "Expected to be different"
		assert @obj2.eql?(@obj3), "Expected to be the same object"
		assert @obj1 == @obj2, "Expected to be equal as they have the same content"
	end

	def test_object_class
		assert_equal @obj1.class, String, "Expected to be of the class String"
		assert_equal @obj1.class, @obj2.class, "Expected to be of the same class"
		assert @obj1.class == String, "Should be true as @obj1 is a String"
		assert @obj1.is_a?(String), "Should be true as @obj1 is a String"
	end

end