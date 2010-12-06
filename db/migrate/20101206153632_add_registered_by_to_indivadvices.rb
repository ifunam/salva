class AddRegisteredByToIndivadvices < ActiveRecord::Migration
 def self.up
    if column_exists? :indivadvices, :moduser_id
      rename_column :indivadvices, :moduser_id, :registered_by_id
    else
      add_column :indivadvices, :registered_by_id, :integer
    end

    add_column :indivadvices, :modified_by_id, :integer
  end

  def self.down
    rename_column :user_journals, :registered_by_id, :moduser_id
    remove_column :user_journals, :modified_by_id
  end
  
end
