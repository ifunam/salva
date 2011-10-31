class RemoveStartMonthAndStartYearAndEndMonthAndEndYearFromJobpositions < ActiveRecord::Migration
  def self.up
    remove_column :jobpositions, :startmonth
    remove_column :jobpositions, :startyear
    remove_column :jobpositions, :endmonth
    remove_column :jobpositions, :endyear
  end

  def self.down
    add_column :jobpositions, :startmonth, :integer
    add_column :jobpositions, :startyear, :integer
    add_column :jobpositions, :endmonth, :integer
    add_column :jobpositions, :endyear, :integer
  end
end
