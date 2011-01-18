class FixOldDbAndChangeColumnTypeUser < ActiveRecord::Migration
  def self.up
    # si pudiesemos saber el tipo de una columna en una tabla....
  #   add_column :users, :temp_author_name, :text
  #   User.find(:all).each do |record|
  #     record.temp_author_name = record.author_name
  #     record.save
  #   end
  #   remove_column :users, :author_name
  #   rename_column  :users, :temp_author_name, :author_name
  # end
    change_column :users, :author_name, :text
  end

  def self.down
  end
end
