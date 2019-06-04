class AddKnowledgeFieldIdToKnowledgeAreas < ActiveRecord::Migration
  def change
    add_column :knowledge_areas, :knowledge_field_id, :integer
  end
end
