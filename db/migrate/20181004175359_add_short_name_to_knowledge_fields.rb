class AddShortNameToKnowledgeFields < ActiveRecord::Migration
  def change
    add_column :knowledge_fields, :short_name, :text
  end
end
