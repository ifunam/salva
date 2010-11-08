class AddIsEnabledToAdscriptions < ActiveRecord::Migration
  def self.up
    add_column :adscriptions, :is_enabled, :boolean, :default => false
  end

  def self.down
    remove_column :adscriptions, :is_enabled
  end
end
