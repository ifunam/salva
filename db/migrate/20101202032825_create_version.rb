class CreateVersion < ActiveRecord::Migration
  def self.up
    unless table_exists? :versions
      create_table :versions do |t|
        t.integer  :version_id
        t.string   :versioned_type
        t.text     :changes
        t.integer  :number
        t.timestamps
      end
    end
  end

  def self.down
    drop_table :versions
  end
end
