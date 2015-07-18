require './emphasis_marker'

class Chisel

  def markdown_to_html(incoming_text)
    pm = ParagraphMarker.new
    paragraphs = pm.mark_paragraphs(incoming_text)
    hm = HeaderMarker.new
    headers = hm.mark_headers(paragraphs)
    sm = StrongMarker.new
    stronged = sm.mark_stronged(headers)
    lm = ListMarker.new
    lists = lm.mark_lists(stronged)
    em = EmphasisMarker.new
    fully_marked = em.mark_emphasis(lists)
    fully_marked
  end

end

#File_IO read file

#Sends read text to Chisel

#Chisel calls the following:
  #list marker --> emphasis
  #emphasis --> strong
  #strong --> header
  #header --> paragraph

#File_IO takes chisel output, writes to file
