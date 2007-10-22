require 'yaml'
module Salva
  def get_conf(name)
    ymlfile =  File.join(RAILS_ROOT, 'config', 'site.yml')
    conf = YAML::parse(File.open(ymlfile)).transform
    conf[name] ? conf[name] : "#{name} no esta definido en #{ymlfile}"
  end
  
  def get_myinstitution
    administrative_key = get_conf('administrative_key')
    Institution.find(:first, :conditions => ['administrative_key = ?',  administrative_key]) if administrative_key.is_a? Integer
  end

  def get_myschool
    myschool = get_conf('most_common_school')
    Institution.find(:first, :conditions => ['id = ?',  myschool]) if myschool.is_a? Integer
  end
end
