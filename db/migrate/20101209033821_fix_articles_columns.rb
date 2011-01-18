class FixArticlesColumns < ActiveRecord::Migration
  def self.up
    unless column_exists? :articles, :doi
      add_column :articles, :doi, :text
    end
    unless column_exists? :articles, :is_verified
      add_column :articles, :is_verified, :boolean, :default => false
    end
    if column_exists? :articles, :miarbitration
      rename_column :articles, :miarbitration, :journal_is_indexed
    end
    if column_exists? :articles, :miarbitrary
      remove_column :articles, :miarbitrary
    end
  end

  def self.down
  end
end
