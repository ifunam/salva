require 'finder'
require 'xml_generator'
class Reporter

  attr_accessor :config

  def initialize(config)
    @config = config
  end
                 
  def xml
    generator = XmlGenerator.new
    @config.each { | item |
      f = Finder.new(*item[:query])
      generator.addPair(f.as_hash)
    }
    generator.as_xml
  end
end
