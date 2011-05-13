class AddRegisteredByToChapterinbookRoleinchapters < ActiveRecord::Migration
  def self.up
    if column_exists?  :chapterinbook_roleinchapters, :moduser_id
      rename_column :chapterinbook_roleinchapters, :moduser_id, :registered_by_id
    else
      add_column :chapterinbook_roleinchapters, :registered_by_id, :integer
    end
    add_column :chapterinbook_roleinchapters, :modified_by_id, :integer
  end

  def self.down
    rename_column :chapterinbook_roleinchapters, :registered_by_id, :moduser_id
    remove_column :chapterinbook_roleinchapters, :modified_by_id
  end
end
