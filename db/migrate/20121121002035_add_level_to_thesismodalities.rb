class AddLevelToThesismodalities < ActiveRecord::Migration
  def change
    add_column :thesismodalities, :level, :integer
  end
end
