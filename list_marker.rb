require './strong_marker'

class ListMarker

  def mark_lists(incoming_text)
    split_text = splitter(incoming_text)
    tagged_text = list_differentiator(split_text)
    joined_text = text_joiner(tagged_text)
    joined_text
  end


  def splitter(incoming_text)
    split_text = incoming_text.split("\n\n")
  end

  def list_differentiator(incoming_text)
    tagged_text = incoming_text.map do |chunk|
      if chunk[0] == "*"
        chunk = add_list_element_tags(chunk)
        chunk = add_unordered_tags(chunk)
      elsif chunk [0] == "1"
        chunk = add_list_element_tags(chunk)
        chunk = add_ordered_tags(chunk)
      else
        chunk
      end
    end
    tagged_text
  end

  def add_list_element_tags(chunk)
    chunk = chunk.split("\n").collect do |line|
      if chunk[0] == "*"
       line = "  <li>" + line.slice(2..-1) + "</li>"
      else
       line = "  <li>" + line.slice(3..-1) + "</li>"
     end
    end
    chunk = chunk.join("\n")
  end

  def add_unordered_tags(list)
    list = "<ul>\n" + list + "\n</ul>"
  end

  def add_ordered_tags(list)
    list = "<ol>\n" + list + "\n</ol>"
  end

  def text_joiner(incoming_text)
    incoming_text.join("\n\n")
  end

end
