class AddRegisteredByToCareers < ActiveRecord::Migration
  def self.up
    if column_exists? :careers, :moduser_id
      rename_column :careers, :moduser_id, :registered_by_id
    else
      add_column :careers, :registered_by_id, :integer
    end
    add_column :careers, :modified_by_id, :integer
  end

  def self.down
    rename_column :careers, :registered_by_id, :moduser_id
    remove_column :careers, :modified_by_id
  end
end
