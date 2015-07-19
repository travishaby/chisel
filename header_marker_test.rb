gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './header_marker'
require './paragraph_marker_test'

class HeaderMarkerTest < Minitest::Test
  def test_blank_strand
    #changed to a blank array since joiner and splitter were
    #removed from paragraph and header classes
    hm = HeaderMarker.new
    assert_equal "", hm.mark_headers([""])
  end

  # def test_that_lines_are_separated_on_chunk
  #   skip #paragraph now enters the header class as an array split on \n\n already
  #   hm = HeaderMarker.new
  #   assert_equal ["Does", "This", "Separate"], hm.paragraph_splitter("Does\n\nThis\n\nSeparate")
  # end

  def test_for_not_adding_tags_at_line_not_beginning_in_a_hash
    hm = HeaderMarker.new
    assert_equal ["These", "shouldn't", "get", "tagged"], hm.header_tag_adder(["These", "shouldn't", "get", "tagged"])
  end

  def test_that_h1_tag_is_added_with_whitespace_removed
    hm = HeaderMarker.new
    assert_equal ["<h1>These</h1>", "<h1>are</h1>", "<h1>header</h1>", "<h1>one</h1>"], hm.header_tag_adder(["# These", "# are", "# header", "# one"])
  end

  def test_that_h2_and_h3_tags_are_added
    hm = HeaderMarker.new
    assert_equal ["<h2>These</h2>", "<h2>are</h2>", "<h2>header</h2>", "<h2>two</h2>", "<h3>and</h3>", "<h3>three</h3>"], hm.header_tag_adder(["## These", "## are", "## header", "## two", "### and", "### three"])
  end

  def test_that_various_tags_are_added_in_a_mixed_string
    hm = HeaderMarker.new
    assert_equal ["<h5>These</h5>", "<h4>are</h4>", "<p>all</p>", "<h2>mixed</h2>", "<h1>up</h1>"], hm.header_tag_adder(["##### These", "#### are", "<p>all</p>", "## mixed", "# up"])
  end

  def test_that_short_array_is_joined_properly
    hm = HeaderMarker.new
    assert_equal "just\n\nchecking\n\nto see if these join together\n\n<h1>properly</h1>", hm.text_joiner(["just", "checking", "to see if these join together", "<h1>properly</h1>"])
  end

  def test_that_it_all_works_together
    hm = HeaderMarker.new
    assert_equal "Does\n\nthis\n\njoin\neven\n\n<h1>though</h1>\n\n<h2>it seems more</h2>\n\n<h5>complex?</h5>", hm.mark_headers(["Does", "this", "join\neven", "# though", "## it seems more", "##### complex?"])
  end

end
