class AddStatusDocumenttypes < ActiveRecord::Migration
  def self.up
    add_column :documenttypes, :status, :boolean, :default => false
  end

  def self.down
    remove_column :documenttypes, :status
  end
end
