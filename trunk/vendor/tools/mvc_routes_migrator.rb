
#!/usr/bin/env ruby
RAILS_ENV = 'development'
require File.dirname(__FILE__) + '/../../config/environment'
require 'test_help'
require 'find'

exceptions = %w(application.rb wizard_controller.rb salva_controller.rb person_controller.rb stack_controller.rb

user_controller.rb  annual_activities_report_controller.rb user_document_controller.rb document_controller.rb
documenttype_controller.rb admin_user_controller.rb multisalva_controller.rb user_stimulus_controller.rb
rbac_controller.rb has_many_keys_controller.rb  addresses_controller.rb navigator_controller.rb navigation_controller.rb documents_controller.rb controllers_controller.rb actions_controller.rb)

Find.find(RAILS_ROOT + '/app/controllers/') do |file|
   if file =~ /[\w]*.rb$/
     next if exceptions.include? file.split('/').last
     controller = file.split('/').last.gsub(/_controller.rb$/,'')
     pluralized_controller = Inflector.pluralize(controller)
     pluralized_filename = pluralized_controller + '_controller.rb'
     pluralized_file = RAILS_ROOT + '/app/controllers/' + pluralized_filename
     `ruby -pe 'gsub(/class #{Inflector.pluralize(controller).classify}/, "class #{Inflector.pluralize(controller).camelize}")' < #{file} > #{pluralized_file}`
     `cd #{RAILS_ROOT + '/app/controllers/'} && mv #{pluralized_file} #{file}`
     `cd #{RAILS_ROOT + '/app/controllers/'} && git mv #{file.split('/').last} #{pluralized_filename}`

     #    # Getting quickposts from _form partial
     orig_view = controller
     new_view = pluralized_controller
      if File.directory?(RAILS_ROOT + '/app/views/' + orig_view) and !File.directory?(RAILS_ROOT + '/app/views/' + new_view)
        `cd #{RAILS_ROOT + '/app/views/'} && git mv #{orig_view} #{new_view}`
        puts "\tmap.resources :#{pluralized_controller}"
      end
    end
end
