require 'yaml'
module Salva
  SALVA = {}
  
  def get(symbol, section)
    if section == 'config'
      SALVA[section][symbol] || 'Check your file config/salva.yml: '+symbol.to_s+' is undefined.'
    else
      'The section:'+section.to_s+' is undefined.'
    end
  end   

  def self.load_config_settings
    filename =  File.join(RAILS_ROOT, 'config', 'salva.yml')
    config = YAML::parse(File.open(filename))
    tree = config.transform
    
    symbol = Hash.new
    tree.each do |section, subsections|
      subsections.each do |key, value|
        newkey = section.to_s+"_"+key.to_s
        symbol[newkey.to_sym] = value 
      end
    end
    SALVA['config'] = symbol
  end
end
