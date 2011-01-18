class FixOldDbRenameColumnsInVersions < ActiveRecord::Migration
  def self.up
    unless column_exists? :versions, :versioned_id
      rename_column :versions, :version_id, :versioned_id
    end

    if column_exists? :versions, :updated_at
      remove_column :versions, :updated_at
    end
  end

  def self.down
  end
end
