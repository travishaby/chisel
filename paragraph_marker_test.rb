gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './paragraph_marker'

class ParagraphMarkerTest < Minitest::Test
  def test_blank_strand
    pm = ParagraphMarker.new
    assert_equal "", pm.mark_paragraphs("")
  end

  def test_that_lines_are_separated_on_chunk
    pm = ParagraphMarker.new
    assert_equal ["Does", "This", "Separate"], pm.paragraph_splitter("Does\n\nThis\n\nSeparate")
  end

  def test_that_string_doesnt_start_separate_on_one_line_end
    pm = ParagraphMarker.new
    assert_equal ["This\nstring\nshouldn't\nseparate"], pm.paragraph_splitter("This\nstring\nshouldn't\nseparate")
  end

  def test_for_not_adding_tags_at_line_beginning_in_a_hash
    pm = ParagraphMarker.new
    assert_equal ["#These", "#shouldn't", "#get", "#tagged"], pm.tag_adder(["#These", "#shouldn't", "#get", "#tagged"])
  end

  def test_for_adding_tags_at_line_beggining_without_hashes
    pm = ParagraphMarker.new
    assert_equal ["<p>These</p>", "<p>should</p>", "<p>get</p>", "<p>tagged</p>"], pm.tag_adder(["These", "should", "get", "tagged"])
  end

  def test_mixed_text_for_tags_and_no_tags
    pm = ParagraphMarker.new
    assert_equal ["#Some", "<p>of\nThese</p>", "#should", "<p>get</p>", "#tagged"], pm.tag_adder(["#Some", "of\nThese", "#should", "get", "#tagged"])
  end

  def test_that_short_array_is_joined_with_proper_paragraph_spacing
    pm = ParagraphMarker.new
    assert_equal "<p>Does</p>\n\n<p>This</p>\n\n<p>Join</p>", pm.line_joiner(["<p>Does</p>", "<p>This</p>", "<p>Join</p>"])
  end

  def test_the_whole_process
    pm = ParagraphMarker.new
    assert_equal "#Some\n\n<p>of\nThese</p>\n\n#should\n\n<p>get</p>\n\n#tagged", pm.mark_paragraphs("#Some\n\nof\nThese\n\n#should\n\nget\n\n#tagged")
  end
end
