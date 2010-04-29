class AddTitleToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :title, :string
  end

  def self.down
    remove_column :people, :title
  end
end
