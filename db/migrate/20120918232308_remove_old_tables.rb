class RemoveOldTables < ActiveRecord::Migration
  def up
    %w(permissions controllers user_grants grants actions).each do |table_name|
      drop_table table_name if table_exists? table_name
    end
  end

  def down
  end
end
