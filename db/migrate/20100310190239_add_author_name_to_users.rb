class AddAuthorNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :author_name, :string
  end

  def self.down
    remove_column :users, :author_name
  end
end
