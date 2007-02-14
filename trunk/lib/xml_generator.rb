class XmlGenerator

  attr_accessor :content

  def initialize()
    @content = []
  end

  def addPair(pair)
    @content << pair
  end

  def as_xml
    xml = ''
    @content.collect { |pair|      
      if pair[1].is_a? Array then
        pluralized_name = Inflector.pluralize(pair[0])
        xml += "<#{pluralized_name}>\n"+
        pair[1].collect { |hash|
          XmlSimple.xml_out(hash, 'rootname' => pair[0], 'noattr' => true)
        }.join("\n")+"</#{pluralized_name}>\n"
      else
        xml += XmlSimple.xml_out(pair[1], 'rootname' => pair[0], 'noattr' => true)
      end
    }
    xml
  end

end  
