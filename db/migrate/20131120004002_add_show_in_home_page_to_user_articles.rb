class AddShowInHomePageToUserArticles < ActiveRecord::Migration
  def change
    add_column :user_articles, :show_in_home_page, :boolean, :default => false
  end
end
