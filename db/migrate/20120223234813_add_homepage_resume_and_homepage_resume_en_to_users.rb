class AddHomepageResumeAndHomepageResumeEnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :homepage_resume, :text
    add_column :users, :homepage_resume_en, :text
  end
end
