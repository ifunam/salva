class GeneratePersonId < ActiveRecord::Migration
  def self.up
      i = 0
      Person.find(:all).each do |record|
        i += 1
        record.id = i
        record.save
      end
      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
        execute "ALTER SEQUENCE people_id_seq RESTART WITH #{i};" if i > 0
      end
  end

  def self.down
  end
end
