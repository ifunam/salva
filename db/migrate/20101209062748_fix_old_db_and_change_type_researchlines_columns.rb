class FixOldDbAndChangeTypeResearchlinesColumns < ActiveRecord::Migration
  def self.up
    # solo se debe de ejecutar si el tipo de :name_en es varchar
    add_column :researchlines, :temp_name_en, :text
    Researchline.find(:all).each do |record|
      record.temp_name_en = record.name_en
      record.save
    end
    remove_column :researchlines, :name_en
    rename_column :researchlines, :temp_name_en, :name_en
  end

  def self.down
  end
end
