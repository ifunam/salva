require 'rubygems'
require 'xml/libxml'
require 'xml/libxslt'
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
    html.print
  end
end
