class CreateUserKnowledgeAreas < ActiveRecord::Migration
  def change
    create_table :user_knowledge_areas do |t|
      t.references :user
      t.references :knowledge_area
      t.integer    :registered_by_id, :null => false
      t.integer    :modified_by_id, :null => true
      # t.timestamps
    end
  end
end
