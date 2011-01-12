class AddRegisteredByToJobpositionLogs < ActiveRecord::Migration
  def self.up
    rename_column :jobposition_logs, :moduser_id, :registered_by_id
    add_column    :jobposition_logs, :modified_by_id, :integer
  end

  def self.down
    rename_column :jobposition_logs, :registered_by_id, :moduser_id
    remove_column :jobposition_logs, :modified_by_id
  end
end
