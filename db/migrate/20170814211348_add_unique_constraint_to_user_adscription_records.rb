class AddUniqueConstraintToUserAdscriptionRecords < ActiveRecord::Migration
  def change
    add_index :user_adscription_records, [:user_id, :year], unique: true
  end
end
