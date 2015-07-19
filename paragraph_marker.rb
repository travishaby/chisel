class ParagraphMarker

  def mark_paragraphs(text_input)
    split_text = paragraph_splitter(text_input)
    tagged_text = tag_adder(split_text)
    tagged_text
    # joined_text = line_joiner(tagged_text)
    # joined_text
  end

  def paragraph_splitter(text)
    text.split("\n\n")
  end

  def tag_adder(split_text)
    tagged_text = split_text.map do |line|
      if line[0] != "#" && line[0] != "1" && line[0] != "*"
        "<p>" + line + "</p>"
      else
        line
      end
    end
    tagged_text
  end

  # def line_joiner(incoming_text)
  #   incoming_text.join("\n\n")
  # end

end

###PARAGRAPH MARKER###
#1 look at string
#2 on the first line, check to see if theres a # symbol
#3 if no # symbol, insert a <p>tag right before the first word of the sentence
#4 scan the words to see if theres a /n/n.
#5 if a <p> was dropped before, drop a </p> before the /n/n
#6 repeat steps 2-6 for the rest of the lines using /n/n as iteration prompt

# def mark_paragraphs
#   @text_input.each_line("\n\n") do |line|
#     if line.include?("#") == false && line.end_with?("\n")
#       @paragraph_marked_text << line.insert(0, "<p>").insert(-3, "</p>")
#     elsif line.include?("#") == false && line.end_with?("\n") == false
#       @paragraph_marked_text << line.insert(0, "<p>").insert(-1, "</p>")
#       @paragraph_marked_text << "<p>" + line " </p>"
#     else
#       @paragraph_marked_text << line
#     end
#   end
#   @paragraph_marked_text
# end
