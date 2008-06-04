class StandarizePeople < ActiveRecord::Migration
  def self.up
    transaction do
      add_column :people, :id, :serial;
      add_index :people, [:id], :name => :people_id_key, :unique => true
      i = 0
      Person.find(:all).each do |record|
        record.id = i++
        record.save
      end
      execute "ALTER SEQUENCE people_id_seq RESTART WITH #{i};" if i > 0
    end
  end
end
