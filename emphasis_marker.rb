require './list_marker'

class EmphasisMarker

  def mark_emphasis(incoming_text)
    split_text = splitter(incoming_text)
    tagged_text = add_tags(split_text)
    joined_text = join_text(tagged_text)
    joined_text
  end

  def splitter(incoming_text)
    split_text = incoming_text.split("*")
  end

  def add_tags(incoming_text)
    tagged_text = incoming_text.map do |chunk|
      if incoming_text.index(chunk).odd?
        "<em>" + chunk + "</em>"
      else
        chunk
      end
    end
  end

  def join_text(incoming_text)
    joined_text = incoming_text.join("")
  end

end
