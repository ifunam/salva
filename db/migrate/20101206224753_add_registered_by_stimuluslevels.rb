class AddRegisteredByStimuluslevels < ActiveRecord::Migration
  def self.up
    if column_exists? :stimuluslevels, :moduser_id
      rename_column :stimuluslevels, :moduser_id, :registered_by_id
    else
      add_column :stimuluslevels, :registered_by_id, :integer
    end

    add_column :stimuluslevels, :modified_by_id, :integer
  end

  def self.down
    rename_column :stimuluslevels, :registered_by_id, :moduser_id
    remove_column :stimuluslevels, :modified_by_id
  end
end
