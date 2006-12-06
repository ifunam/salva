require 'yaml'
module SalvaHelper 
  def get_cfg(name)
    ymlfile =  File.join(RAILS_ROOT, 'config', 'site.yml')
    site = YAML::parse( File.open(ymlfile) )
    cfg = site.transform    
    cfg[name] ? cfg[name] : "#{name} no esta definido en #{ymlfile}"
  end

  def get_label(name)
    ymlfile =  File.join(RAILS_ROOT, 'po', 'salva.yml')
    salva = YAML::parse( File.open(ymlfile) )
    column = salva.transform    
    column[name] ? column[name] : "#{name} no esta definido en #{ymlfile}"
  end

  def get_myinstitution
    administrative_key = get_cfg('administrative_key')
    if administrative_key.is_a? Integer
      institution = Institution.find(:first, :conditions => ['administrative_key = ?',  administrative_key])
      institution if institution
    end
  end
end
