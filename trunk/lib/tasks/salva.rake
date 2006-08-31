namespace :salva do

  desc "Running tests for salva using salva:test_units"
  task :test_units do
    Rake::Task['salva:db_schema_load'].invoke
    require 'find'
    unit_path = "#{RAILS_ROOT}/test/unit"
    Find.find(unit_path) do |unit_test_path|
      next unless File.file?(unit_test_path) and unit_test_path =~ /[\w+]\_test.rb$/
      ruby unit_test_path
       print "\n"
    end
  end
  
  desc "Creating tables for salva using salva:db_schema_load"
  task :db_schema_load do
    RAILS_ENV = 'test'
    Rake::Task['db:schema:load'].invoke
  end

end
