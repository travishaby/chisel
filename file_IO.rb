require './chisel'

handle = File.open(ARGV[0], "r")

incoming_text = handle.read

handle.close

outgoing_text = Chisel.new.markdown_to_html(incoming_text)

writer = File.open(ARGV[1], "w")

writer.write(outgoing_text)

writer.close
