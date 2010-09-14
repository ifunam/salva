class AddStartDateAndEndDateToUserSchoolarships < ActiveRecord::Migration
  def self.up
    add_column :user_schoolarships, :start_date, :date
    add_column :user_schoolarships, :end_date, :date
  end

  def self.down
    remove_column :user_schoolarships, :end_date
    remove_column :user_schoolarships, :start_date
  end
end
