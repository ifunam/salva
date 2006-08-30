namespace :salva do

  desc "Running tests for salva using salva:test_units"
  task :test_units do
    Rake::Task['salva:db_schema_load'].invoke
    ruby "#{RAILS_ROOT}/test/unit/userstatus_test.rb"
  end
  
  desc "Creating tables for salva using salva:db_schema_load"
  task :db_schema_load do
    RAILS_ENV = 'test'
    Rake::Task['db:schema:load'].invoke
  end

end
