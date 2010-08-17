class AddStartDateAndEndDateToUserAdscriptions < ActiveRecord::Migration
    def self.up
      add_column :user_adscriptions, :start_date, :date, :null => false, :default => Date.today
      add_column :user_adscriptions, :end_date, :date
      execute "ALTER TABLE user_adscriptions ALTER COLUMN startyear DROP NOT NULL;"
    end

    def self.down
      remove_column :user_adscriptions, :start_date
      remove_column :user_adscriptions, :end_date
      execute "ALTER TABLE user_adscriptions ALTER COLUMN startyear SET NOT NULL;"
    end
end
