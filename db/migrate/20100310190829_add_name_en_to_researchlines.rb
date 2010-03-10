class AddNameEnToResearchlines < ActiveRecord::Migration
  def self.up
    add_column :researchlines, :name_en, :string
  end

  def self.down
    remove_column :researchlines, :name_en
  end
end
