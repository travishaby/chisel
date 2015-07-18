gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './strong_marker'
require './header_marker_test'

class StrongMarkerTest < Minitest::Test

  def test_blank_strand
    sm = StrongMarker.new
    assert_equal "", sm.mark_stronged("")
  end

  def test_split_on_one_word
    sm = StrongMarker.new
    assert_equal ["", "word"], sm.splitter("**word**")
  end

  def test_split_on_double_astrisks
    sm = StrongMarker.new
    assert_equal ["<p>This is a normal sentence. ", "This one is really important!", " This one is not.</p>\n\n<p>Hey it's a new paragraph.</p>"], sm.splitter("<p>This is a normal sentence. **This one is really important!** This one is not.</p>\n\n<p>Hey it's a new paragraph.</p>")
  end

  def test_split_on_double_astrisks_with_complex_sentence
    sm = StrongMarker.new
    assert_equal ["This is a ", "normal", " sentence. ", "This one is really important!", " *This one is not.*"], sm.splitter("This is a **normal** sentence. **This one is really important!** *This one is not.*")
  end

  def test_that_strong_tags_are_added_to_simple_sentence
    sm = StrongMarker.new
    assert_equal ["This is a ", "<strong>really</strong>", " important word"], sm.add_tags(["This is a ", "really", " important word"])
  end

  def test_that_strong_tags_are_added_to_complex_sentence
    sm = StrongMarker.new
    assert_equal ["This is a ", "<strong>really</strong>", " important word *but* not as <p>important as", "<strong>this</strong>", "paragraph.</p>"], sm.add_tags(["This is a ", "really", " important word *but* not as <p>important as", "this", "paragraph.</p>"])
  end

  def test_that_the_text_in_the_array_is_joined_properly
    sm = StrongMarker.new
    assert_equal "<p>Does</p> this <strong>really</strong> join the right <strong>way?</strong>", sm.join_text(["<p>Does</p> this ", "<strong>really</strong>", " join", " the right ", "<strong>way?</strong>"])
  end

  def test_the_whole_shabang
    sm = StrongMarker.new
    assert_equal "Hey *look* all of *these* things have <strong>strong</strong> tags and they're in the <strong>same</strong> sentence!", sm.mark_stronged("Hey *look* all of *these* things have **strong** tags and they're in the **same** sentence!")
  end

end
