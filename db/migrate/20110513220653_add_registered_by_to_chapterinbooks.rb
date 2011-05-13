class AddRegisteredByToChapterinbooks < ActiveRecord::Migration
  def self.up
    if column_exists?  :chapterinbooks, :moduser_id
      rename_column :chapterinbooks, :moduser_id, :registered_by_id
    else
      add_column :chapterinbooks, :registered_by_id, :integer
    end
    add_column :chapterinbooks, :modified_by_id, :integer
  end

  def self.down
    rename_column :chapterinbooks, :registered_by_id, :moduser_id
    remove_column :chapterinbooks, :modified_by_id
  end
end
