require 'iconv'
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

  desc "Dump an existing table in development environment to create YAML test fixtures. Use the parameter table=tablename"
  task :table_to_fixtures => :environment do
    path  = ENV['DEST'] || "#{RAILS_ROOT}/test/fixtures"
    db    = ENV['DB']   || 'development'
    table = ENV['table']
    limit = ENV['limit'] || 3
    sql   = "SELECT * FROM #{table} LIMIT #{limit}"

    ActiveRecord::Base.establish_connection(db)
    print "Extracting records from #{table}: "
    i = '000'
     File.open("#{path}/#{table}.yml", 'wb') do |file|
       file.write ActiveRecord::Base.connection.select_all(sql).inject({}) { |hash, record|
         key = set_keyname(record,i,table)
         %w(moduser_id created_on updated_on).each { |k| record.delete(k) if record.has_key?(k)}
         record.keys.each {|k|
           if k =~ /(_)*id$/ then
             record[k] = record[k].to_i
           else
             record[k] = record[k].chars.strip.to_s
           end
        }
        print "."
        hash[key] = record
        hash # Aún existe un bug con UTF8
       }.to_yaml(:Encoding => :Utf8, :Emiter => 'Salva fixtures generator')

    end
    print "\n"
  end

  def set_keyname(record,i,table)
    if record.has_key?('abbrev') then
      keyname(record, 'abbrev')
    elsif record.has_key?('name') then
      keyname(record, 'name')
    elsif record.has_key?('title') then
      keyname(record, 'title')
    else
      "#{table}_#{i.succ!}"
    end
  end

  def keyname(record,attribute)
    Inflector.underscore(record[attribute].chars.downcase.strip.normalize.gsub(/\s/,'_'))
  end

end
