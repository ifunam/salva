class CreateUserLabOrGroups < ActiveRecord::Migration
  def self.up
    create_table :user_lab_or_groups do |t|
      t.references :user
      t.references :lab_or_group
      t.integer    :registered_by_id, :null => false
      t.integer    :modified_by_id, :null => true
    end
  end

  def self.down
    drop_table :user_lab_or_groups
  end
end
