class AddShortNameToKnowledgeAreas < ActiveRecord::Migration
  def change
    add_column :knowledge_areas, :short_name, :text
  end
end
