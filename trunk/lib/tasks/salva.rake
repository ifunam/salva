require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require File.expand_path(File.dirname(__FILE__) + "/../../test/ordered_fixtures")

namespace :salva do

  desc "Run tests for salva using unitsdb:schema:load"
  task :test_units do
    RAILS_ENV = 'test'
    Rake::Task['db:schema:load'].invoke
    #Rake::Task['salva:load_fixtures_ordered'].invoke
  end
  
  ENV["FIXTURE_ORDER"] ||= ""
  desc "Load fixtures into #{ENV['RAILS_ENV']} database"
  task :load_fixtures_ordered => :environment do
    require 'active_record/fixtures'  
    ordered_fixtures = Hash.new
    ENV["FIXTURE_ORDER"].split.each { |fx| ordered_fixtures[fx] = nil }
    other_fixtures = Dir.glob(File.join(RAILS_ROOT, 'test', 'fixtures', '*.{yml,csv}')).collect { |file| File.basename(file, '.*') }.reject {|fx| ordered_fixtures.key? fx }
    ActiveRecord::Base.establish_connection(ENV['RAILS_ENV'])
    (ordered_fixtures.keys + other_fixtures).each do |fixture|
      Fixtures.create_fixtures('test/fixtures',  fixture)
    end unless :environment == 'production' 
  end
  # You really don't want to load your *fixtures* 
  # into your production database, do you?  
end
