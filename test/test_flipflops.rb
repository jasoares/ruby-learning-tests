require File.expand_path('../test_helpers', __FILE__)

class TestFlipFlops < MiniTest::Unit::TestCase

  def test_flip_flop_operator1
    count = 0
    (1..4).each { |x| count += 1 if x==2..x>=2 }
    assert_equal 1, count, "Should execute count += 1 on x == 2"
  end

  def test_flip_flop_operator2
    count = 0
    (1..4).each { |x| count += 1 if x==2...x>=2 }
    assert_equal 2, count, "Should execute count += 1 on x == 2..3"
  end

  def test_flip_flop_operator_real_world_usage
    dictionary = %w[ ball chair chandelier person square stone table window ]
    s_to_t_words = []
    dictionary.each { |word| s_to_t_words << word if /\As/i =~ word../\At/i =~ word }
    assert_equal ['square', 'stone', 'table'], s_to_t_words, "Should be assigned only words started from s to t"
  end

  def test_flip_flop_operator_real_world_usage_2
    # Extract a c comment from source code
    c_file = 
'include <stdio.h>

/* this is the start of a c comment
that continues in the following line
and only stops here */

main(){
  printf("Hello World");
}
'
    expected_comment = 
'/* this is the start of a c comment
that continues in the following line
and only stops here */
'
    comment = ""
    c_file.each_line { |l| comment << l if /\/\*/ =~ l.../\*\// =~ l }
    assert_equal expected_comment, comment, "Should append the lines that compose the comment"
  end

end
