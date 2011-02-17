class AddRegisteredByToThesisJurors < ActiveRecord::Migration
  def self.up
    if column_exists?  :thesis_jurors, :moduser_id
      rename_column :thesis_jurors, :moduser_id, :registered_by_id
    else
      add_column :thesis_jurors, :registered_by_id, :integer
    end

    add_column :thesis_jurors, :modified_by_id, :integer
  end

  def self.down
    rename_column :thesis_jurors, :registered_by_id, :moduser_id
    remove_column :thesis_jurors, :modified_by_id
  end
end
