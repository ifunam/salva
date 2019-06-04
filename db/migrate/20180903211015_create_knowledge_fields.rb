class CreateKnowledgeFields < ActiveRecord::Migration
  def change
    create_table :knowledge_fields do |t|
      t.text       :name
      t.text       :name_en
      # t.timestamps
    end
  end
end
