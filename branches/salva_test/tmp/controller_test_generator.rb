 #!/usr/bin/env ruby
RAILS_ENV = 'development'
require File.dirname(__FILE__) + '/../config/environment'
require 'test_help'
require 'find'
require 'yaml'

def write_test(controller, controller_class, model, fixtures, data_fixtures, quickposts)
  test = RAILS_ROOT+ '/test/functional/' + controller + '_test.rb'
  unless File.exists?(test)
    File.open(test,"w") do |file|
      file.puts "require 'salva_controller_test'"
      file.puts "require '#{controller}'"
      file.print "\n"
      file.puts "class #{controller_class}; def rescue_action(e) raise e end; end"
      file.print "\n"
      file.puts "class  #{controller_class}Test < SalvaControllerTest"
      file.puts "\s\s#{fixtures}"
      file.print "\n"
      file.puts "\s\sdef initialize(*args)"
      file.puts     "\s\s\ssuper"
      file.puts    "\s\s\s@mycontroller =  #{controller_class}.new"
      unless data_fixtures.empty?
        data_fixtures.delete('id')
        f = data_fixtures.keys.collect { |k|
          next if  data_fixtures[k].nil?
          if  data_fixtures[k].is_a? Integer
            ":#{k} => #{data_fixtures[k].to_i}"
          else
            ":#{k} => '#{ActiveSupport::Multibyte::Chars.new(data_fixtures[k]) .to_str}_test'"
          end
          }
        file.puts  "\s\s\s@myfixtures = { #{f.compact.join(", ") } }"
      else
        file.puts "\s\s\s@myfixtures = {}"
      end
      b = data_fixtures.keys.collect { |k|   ":#{k} => nil" }
      file.puts "\s\s\s@mybadfixtures = {  #{b.compact.join(", ")} }"
      file.puts "\s\s\s@model = #{model}"
      unless quickposts.empty?
        file.puts   "\s\s\s@quickposts = [ #{quickposts.compact.join(', ')} ]"
      end
      file.puts "\s\send"
      file.puts "end"
   end
 end
end

exceptions = %w(application wizard_controller salva_controller person_controller stack_controller
user_controller  annual_activities_report_controller user_document_controller document_controller
documenttype_controller admin_user_controller)
print "#controller_name:fixtures:data_fixtures:quickposts \n"
Find.find(RAILS_ROOT + '/app/controllers/') do |file|
  if file =~ /[\w]*.rb$/
    controller = file.split('/').last.gsub(/.rb$/,'')
    next if exceptions.include? controller or File.exists?(RAILS_ROOT + '/test/functional/' + controller + '_test.rb')
    controller_class = Inflector.classify(controller).constantize
    fixtures = ''
    data_fixtures = Hash.new
    quickposts = []
    model = ''
    if controller_class.new.class.superclass.to_s =~ /SalvaController/
      model = Inflector.underscore(controller_class.new.instance_values['model'])
      if File.exists?(RAILS_ROOT + '/test/unit/' + model + '_test.rb')
        model_test = File.new RAILS_ROOT+ '/test/unit/' + model + '_test.rb', 'r'
        # Getting Fixtures file list
        model_test.readlines.each do |line|
           fixtures = line.sub(/:userstatuses, /,'').sub(/:users, /,'').sub(/  /,' ') and break  if line =~ /fixtures/
        end
        # Getting data fixtures for this controller
        fixtures_yml = RAILS_ROOT + '/test/fixtures/' + Inflector.pluralize(model) + '.yml'

        if File.exists?(fixtures_yml)
          yaml = YAML.parse_file(fixtures_yml)
          data_fixtures = yaml.transform[yaml.transform.keys.first.to_s]
        end
        # Getting quickposts from _form partial
        form_rhtml = RAILS_ROOT + '/app/views/' + controller.sub(/_controller$/,'') + '/_form.rhtml'

        if File.exists?(form_rhtml)
          form = File.new form_rhtml, 'r'
          form.readlines.each do |line|
             quickposts << line.split('(').last.split(')').first and break  if line =~ /quickpost/
          #..
          end
        end
      end
      model_class = model
      model_class << 's'  if model  =~/[\w]*u$/ or model  =~/[\w]*i$/
      write_test(controller, controller_class, Inflector.camelize(model_class), fixtures, data_fixtures, quickposts)
      output = [
                controller + '_test',
                (fixtures.length > 0 ? 'ok' : '*'),
                ((data_fixtures.empty?) ? '*'  : 'ok'),
                ((quickposts.empty?) ? '*'  : 'ok')
               ]
      print output.join(':'), "\n"
   end
 end
end


#fixtures = 'fixtures :institutiontitles, :institutiontypes, :institutions'
#data_fixtures = {:name => 'unam', :country_id => 486 , :id => 1 }
#quickposts =  %w(country state city)




