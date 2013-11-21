class SetDefaultForShowInHomePageInUserArticles < ActiveRecord::Migration
  def up
    UserArticle.all.each do |p|
      p.update_attribute :show_in_home_page, false
    end
  end

  def down
  end
end
