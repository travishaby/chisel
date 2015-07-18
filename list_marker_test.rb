gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './list_marker'
require './strong_marker_test'

class ListMarkerTest < Minitest::Test

  def test_blank_string
    lm = ListMarker.new
    assert_equal "", lm.mark_lists("")
  end

  def test_that_string_splits_on_break
    lm = ListMarker.new
    assert_equal ["Hey", "does", "this", "split?"], lm.splitter("Hey\n\ndoes\n\nthis\n\nsplit?")
  end

  def test_that_element_tags_are_added
    lm = ListMarker.new
    assert_equal   "  <li>unordered</li>\n  <li>lists</li>\n  <li>seem</li>\n  <li>hard</li>", lm.add_list_element_tags("* unordered\n* lists\n* seem\n* hard")
  end

  def test_that_unordered_list_tags_are_placed
    lm = ListMarker.new
    assert_equal "<ul>\n  <li>an item</li>\n</ul>", lm.add_unordered_tags("  <li>an item</li>")
  end

  def test_that_ordered_list_tags_are_placed
    lm = ListMarker.new
    assert_equal "<ol>\n  <li>an item</li>\n</ol>", lm.add_ordered_tags("  <li>an item</li>")
  end

  def test_that_both_unordered_list_and_element_tags_are_added
    lm = ListMarker.new
    assert_equal ["a string that I am testing", "<ul>\n  <li>unordered</li>\n  <li>lists</li>\n  <li>seem</li>\n  <li>hard</li>\n</ul>", "also testing this and this."], lm.list_differentiator(["a string that I am testing", "* unordered\n* lists\n* seem\n* hard", "also testing this and this."])
  end

  def test_that_both_ordered_list_and_element_tags_are_added
    lm = ListMarker.new
    assert_equal ["a string that I am testing", "<ol>\n  <li>unordered</li>\n  <li>lists</li>\n  <li>seem</li>\n  <li>hard</li>\n</ol>", "also testing this and this."], lm.list_differentiator(["a string that I am testing", "1. unordered\n2. lists\n3. seem\n4. hard", "also testing this and this."])
  end

  def test_that_text_joins_properly
    lm = ListMarker.new
    assert_equal "a string that I am testing\n\n<ul>\n  <li>unordered</li>\n  <li>lists</li>\n  <li>seem</li>\n  <li>hard</li>\n</ul>\n\nalso testing this and this.", lm.text_joiner(["a string that I am testing", "<ul>\n  <li>unordered</li>\n  <li>lists</li>\n  <li>seem</li>\n  <li>hard</li>\n</ul>", "also testing this and this."])
  end

  def test_all_methods_working_together
    lm = ListMarker.new
    assert_equal "here i am wondering if\n\n<ul>\n  <li>unordered</li>\n  <li>lists</li>\n  <li>seem</li>\n  <li>hard</li>\n</ul>\n\nor maybe i've solved the problem.", lm.mark_lists("here i am wondering if\n\n* unordered\n* lists\n* seem\n* hard\n\nor maybe i've solved the problem.")
  end
end
