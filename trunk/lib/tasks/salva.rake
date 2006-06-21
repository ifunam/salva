namespace :salva do
  desc "Run tests for salva using unitsdb:schema:load"
  task :test_units do
    RAILS_ENV = 'test'
    Rake::Task['db:schema:load'].invoke
  end
end
