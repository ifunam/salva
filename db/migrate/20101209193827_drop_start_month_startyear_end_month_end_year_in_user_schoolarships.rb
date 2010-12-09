class DropStartMonthStartyearEndMonthEndYearInUserSchoolarships < ActiveRecord::Migration
  def self.up
    %w(startmonth startyear endmonth endyear).each do |column_name|
      remove_column :user_schoolarships, column_name.to_sym
    end
  end

  def self.down
    %w(startmonth startyear endmonth endyear).each do |column_name|
      add_column :user_schoolarships, column_name.to_sym, :integer
    end
  end
end
