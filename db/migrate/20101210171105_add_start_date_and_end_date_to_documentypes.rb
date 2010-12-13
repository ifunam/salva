class AddStartDateAndEndDateToDocumentypes < ActiveRecord::Migration
  def self.up
    add_column :documenttypes, :start_date, :date
    add_column :documenttypes, :end_date, :date
    add_column :documenttypes, :year, :integer
  end

  def self.down
    remove_column :documenttypes, :start_date
    remove_column :documenttypes, :end_date
    remove_column :documenttypes, :year
  end
end
