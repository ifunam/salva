class AddRegisteredByToEducations < ActiveRecord::Migration
  def self.up
    rename_column :educations, :moduser_id, :registered_by_id
    add_column    :educations, :modified_by_id, :integer
  end

  def self.down
    rename_column :educations, :registered_by_id, :moduser_id
    remove_column :educations, :modified_by_id
  end
end
