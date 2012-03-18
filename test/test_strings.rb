require File.expand_path('../test_helpers', __FILE__)

class StringTests < MiniTest::Unit::TestCase

  def test_single_quoted_string_escaped_apostrophe
    assert_equal 'It\'s working', "It's working", "The apostrophe should have been escaped"
  end

  def test_single_quoted_backslash_doesnt_need_escaped_when_followed_by_anything_other_than_a_quote_or_a_backslash
    assert_equal 'a\b', 'a\\b', "The two literals should be equal"
  end

  def test_literals_in_loops_are_different_objects_at_each_loop
    last_id = 0
    2.times do
      curr_id = "abc".object_id
      refute_equal last_id, curr_id, "Strings are mutable in ruby so each loop should create a new string literal."
      last_id = curr_id
    end
  end

  def test_literals_from_variables_are_always_the_same_object_in_loops
    string = "abc"
    string_id = string.object_id
    2.times do
      assert_equal string.object_id, string_id, "A string literal created outside of a loop a passed inside as a variable doesn't get created more than once"
    end
  end

  def test_extending_single_quoted_string_with_newlines
    assert_equal 'This is a long string literal \
    that includes a backslash and a newline',
    "This is a long string literal \\\n    that includes a backslash and a newline",
    "Should be extended with a backslash and a newline"
  end

  def test_extending_single_quoted_string_without_newlines
    assert_equal 'These three literals are '\
    'concatenated into one by the interpreter. '\
    'The resulting string contains no newlines.',
    "These three literals are concatenated into one by the interpreter. The resulting string contains no newlines.",
    "Should be concatenated and should not contain newlines"
  end

  def test_single_quotes_does_not_support_newlines_or_tabs_by_backslash_notation
    assert_equal '\tThis string is not tabbed neither has a new line at the end.\n',
    "\\tThis string is not tabbed neither has a new line at the end.\\n",
    "\\t and \\n should not mean a tab or a newline in a single quoted string"
  end

  def test_double_quoted_string_literals
    assert_equal "\t\"This quote begins with a tab and ends with a newline\"\n",
    "\t" + '"This quote begins with a tab and ends with a newline"' + "\n",
    "The double quotes should be escaped"
  end

  def test_arbitrary_delimiters_for_string_literals
    assert_equal %q(It's a string), "It's a string", "Expected to return true as it is a valid string declaration"
  end

  def test_string_times_operator
    assert_equal "abc" + "abc", "abc"*2, "Concatenation should not differ from the times operator"
  end

  def test_string_interpolation
    variable = "variable"
    assert_equal "this is a string with a #{variable}",
    "this is a string with a variable",
    "The variable should have been replaced by its value"
    a = 3; b = 4
    assert_equal "a + b = #{a + b}", "a + b = 7", "Should be equal to 7"
  end

  def test_string_comparator
    assert_equal "A" <=> "Joao", -1, "Expected to return -1 since A < Joao alphabetically"
    assert_equal "AAAAA" <=> "Joao", -1, "Expected to return -1 since the size of the string doesn't influence the sorting"
  end
end
