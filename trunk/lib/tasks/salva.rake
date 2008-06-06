# -*- coding: utf-8 -*-
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
    path  = ENV['DEST'] || "#{RAILS_ROOT}/db/catalogs"
    db    = ENV['DB']   || 'development'
    table = ENV['table']
    limit = ENV['limit']
    sql   = "SELECT * FROM #{Inflector.tableize(table)} ORDER BY id"
    utc_prefix = Time.now.utc.strftime("%Y%m%d%H%M%S")

    ActiveRecord::Base.establish_connection(db)
    print "Extracting records from #{table}: "
    i = 0
    File.open("#{path}/#{utc_prefix}_#{table}.csv", 'wb') do |file|
      ActiveRecord::Base.connection.select_all(sql).inject({}) { |hash, record|
        %w(moduser_id created_at updated_at).each { |k|
          record.delete(k) if record.has_key?(k)
        }
        keys = (record.keys - ['id'])
        keys.unshift('id')
        file.write keys.join(', ') + "\n" if i == 0
        file.write keys.collect {|k|
          next if record[k].nil?
          if k =~ /(_)*id$/ then
            record[k].to_i
          else
            s = record[k].chars.strip.to_s
            s =~ /,/ ? "\"#{s}\"" : s
          end
        }.compact.join(', ') + "\n"
        i = i + 1
      }
    end
    print "\n"
  end

  desc "...."
  task :db_catalogs_load do
    catalogs_path = "#{RAILS_ROOT}/db/catalogs"
    files = Dir["#{catalogs_path}/[0-9]*_*.csv"]
    catalogs = files.inject([]) do |klasses, file|
      version, name = file.scan(/([0-9]+)_([_a-z0-9]*).csv/).first
      puts file
    end
  end

end
