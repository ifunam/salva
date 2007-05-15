require 'rubygems'
require 'xml/libxml'
require 'xml/libxslt'
require 'rexml/document'
require 'pdf/writer'
class XslTransformer
  def initialize(style)
    @xslt = XML::XSLT.file(style)
  end
  
  def as_html(xml)
    xp = XML::Parser.new()
    xp.string = xml
    @xslt.doc = xp.parse
    html = @xslt.parse
    html.apply
    html.to_s
  end
  
  def as_pdf(xml)
    xp = XML::Parser.new()
    xp.string = xml


    pdf = PDF::Writer.new
    xp.node.each do | string |
      pdf.text(line)
    end
    pdf.render
  end
end


