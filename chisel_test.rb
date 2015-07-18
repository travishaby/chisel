gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './chisel'
require './emphasis_marker_test'

class ChiselTest < Minitest::Test

  def test_blank_string
    chisel = Chisel.new
    assert_equal "", chisel.markdown_to_html("")
  end

  def test_chisel
    chisel = Chisel.new
    assert_equal "<h1>#Some</h1>\n\n<p>of\nThese</p>\n\n<h1>#should</h1>\n\n<p>get</p>\n\n<h1>#tagged</h1>\n\n<p>as well as</p>\n\n<ul>\n  <li>some</li>\n  <li>of</li>\n  <li>these</li>\n</ul>\n\n<strong>other things</strong>\n\n<ol>\n  <li>ordered</li>\n  <li>lists</li>\n  <li>too</li>\n</ol>\n\n<p>new paragraph.</p>", chisel.markdown_to_html("#Some\n\nof\nThese\n\n#should\n\nget\n\n#tagged\n\nas well as\n\n* some\n* of\n* these\n\n**other things**\n\n1. ordered\n2. lists\n3. too\n\nnew paragraph.")
    end

end
