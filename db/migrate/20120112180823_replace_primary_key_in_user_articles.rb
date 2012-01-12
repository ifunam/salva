class ReplacePrimaryKeyInUserArticles < ActiveRecord::Migration
  def up
    execute "ALTER TABLE user_articles DROP CONSTRAINT user_articles_pkey"
    execute "ALTER TABLE user_articles ADD PRIMARY KEY (id)"
  end

  def down
    execute "ALTER TABLE user_articles DROP CONSTRAINT user_articles_pkey"
    execute "CREATE INDEX user_articles_pkey ON user_articles (user_id, article_id)"
  end
end
