class UpdateVersions < ActiveRecord::Migration
  def self.up
    remove_column :versions, :versioned_id
    remove_column :versions, :versioned_type
    remove_column :versions, :changes
    remove_column :versions, :number

    add_column :versions, :item_type, :string
    add_column :versions, :item_id, :integer
    add_column :versions, :event, :string
    add_column :versions, :whodunnit, :string
    add_column :versions, :object, :text

    # add_index :versions, :column => [:item_type, :item_id]
  end

  def self.down
    add_column :versions, :versioned_id, :integer
    add_column :versions, :versioned_type_id, :string
    add_column :versions, :changes, :text
    add_column :versions, :number, :integer

    # remove_index :versions, :column => [:item_type, :item_id]
    remove_column :versions, :item_type
    remove_column :versions, :item_id
    remove_column :versions, :event
    remove_column :versions, :whodunnit
    remove_column :versions, :object
    remove_column :versions, :create_at
  end
end
