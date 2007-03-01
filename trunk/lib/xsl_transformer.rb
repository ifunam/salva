require 'xml/libxml'
require 'xml/libxslt'
class XslTransformer
  def initialize(style, xml, rootname='resume')
    @xslt = XML::XSLT.file(style)
    @xslt.doc = XML::Document.new()
    @xslt.doc.encoding = "UTF-8"
    @xslt.doc.root = XML::Node.new(rootname)
    @xslt.doc.root << xml
  end
  
  def as_html
    html = @xslt.parse
    html.apply
    html.print
  end
end
