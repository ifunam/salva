class AddDegreeIdToThesismodalities < ActiveRecord::Migration
  def change
    add_column :thesismodalities, :degree_id, :integer
  end
end
