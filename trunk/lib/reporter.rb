require 'finder'
require 'xml_generator'
class Reporter

  attr_accessor :queries

  def initialize(report)
    require RAILS_ROOT+"/config/#{report}"
    @queries = QUERIES
  end
  
  def xml
    generator = XmlGenerator.new(MYROOT)
    @queries.each { | item |
      f = Finder.new(*item[:query])
      generator.addPair(f.as_hash)
    }
    generator.as_xml
  end     
  
  def as_html
    xslt = XslTransformer.new(RAILS_ROOT+"/templates/#{MYROOT}/#{STYLE}.xsl")
    xslt.as_html(xml)
  end
end
