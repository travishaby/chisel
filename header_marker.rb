require './paragraph_marker'

class HeaderMarker

  def mark_headers(text_input)
    split_text = paragraph_splitter(text_input)
    tagged_text = header_tag_adder(split_text)
    joined_text = text_joiner(tagged_text)
    joined_text
  end

  def paragraph_splitter(incoming_text)
    incoming_text.split("\n\n")
  end

  def header_tag_adder(incoming_text)
    tagged_text = incoming_text.map do |line|
      if line.include?('#')
        line = "<h#{line.count('#')}>" + line + "</h#{line.count('#')}>"
        line.sub("#"*("#{line.count('#')}".to_i) + " ", "")
      else
        line
      end
    end
  end

  def text_joiner(incoming_text)
    incoming_text.join("\n\n")
  end

end
