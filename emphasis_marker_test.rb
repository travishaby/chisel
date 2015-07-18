gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './emphasis_marker'
require './list_marker_test'

class EmphasisMarkerTest < Minitest::Test

  def test_blank_strand
    sm = EmphasisMarker.new
    assert_equal "", sm.mark_emphasis("")
  end

  def test_split_on_double_astrisks
    sm = EmphasisMarker.new
    assert_equal ["<p>This is a normal sentence. ", "This one is really important!", " This one is not.</p>\n\n<p>Hey it's a new paragraph.</p>"], sm.splitter("<p>This is a normal sentence. *This one is really important!* This one is not.</p>\n\n<p>Hey it's a new paragraph.</p>")
  end

  def test_split_on_double_astrisks_with_complex_sentence
    sm = EmphasisMarker.new
    assert_equal ["This is a ", "normal", " sentence. ", "This one is really important!", " <p>This one is not.</p>"], sm.splitter("This is a *normal* sentence. *This one is really important!* <p>This one is not.</p>")
  end

  def test_that_emphasis_tags_are_added_to_simple_sentence
    sm = EmphasisMarker.new
    assert_equal ["This is a ", "<em>really</em>", " important word"], sm.add_tags(["This is a ", "really", " important word"])
  end

  def test_that_emphasis_tags_are_added_to_complex_sentence
    sm = EmphasisMarker.new
    assert_equal ["This is a ", "<em>really</em>", " important word but not as <p>important as", "<em>this</em>", "paragraph.</p>"], sm.add_tags(["This is a ", "really", " important word but not as <p>important as", "this", "paragraph.</p>"])
  end

  def test_that_the_text_in_the_array_is_joined_properly
    sm = EmphasisMarker.new
    assert_equal "<p>Does</p> this <em>really</em> join the right <em>way?</em>", sm.join_text(["<p>Does</p> this ", "<em>really</em>", " join", " the right ", "<em>way?</em>"])
  end

  def test_the_whole_doohickey
    sm = EmphasisMarker.new
    assert_equal "Hey look all of these things have <em>strong</em> tags and they're in the <em>same</em> sentence!", sm.mark_emphasis("Hey look all of these things have *strong* tags and they're in the *same* sentence!")
  end

end
