require 'yaml'
require 'rubygems'
require_gem 'activerecord'

if RAILS_ROOT then
  ymlfile =  File.join(RAILS_ROOT, 'config', 'database.yml')
  ymlconf = YAML::parse( File.open(ymlfile) )
  conf = ymlconf.transform    
  
  dbuser = conf['login']['username']
  dbpasswd = conf['login']['password']
  dbencoding = conf['login']['encoding']
  dbname = conf[RAILS_ENV]['database']
  
  if dbuser and dbname
    dbparams = [ "--with-db=#{dbname}", "--with-user=#{dbuser}"]
    dbparams << "--with-usepasswd=yes" if dbpasswd
    dbparams << "--with-encoding=#{dbencoding}" if dbencoding
    cd(RAILS_ROOT + '/db')
    system('./configure', *dbparams.to_a)
    system('make drop') if ActiveRecord::Base.establish_connection(conf[RAILS_ENV])
    system('make createdb && make createlang && make create_tables')
    system('make load_catalogs') if RAILS_ENV != 'test'
  end
 end

