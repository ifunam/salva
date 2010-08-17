class AddStartDateAndEndDateToJobpositions < ActiveRecord::Migration
  def self.up
    add_column :jobpositions, :start_date, :date, :null => false, :default => Date.today
    add_column :jobpositions, :end_date, :date
    execute "ALTER TABLE jobpositions ALTER COLUMN startyear DROP NOT NULL;"
  end

  def self.down
    remove_column :jobpositions, :start_date
    remove_column :jobpositions, :end_date
    execute "ALTER TABLE jobpositions ALTER COLUMN startyear SET NOT NULL;"
  end
end
