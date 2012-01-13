class CreateSessionPreferences < ActiveRecord::Migration
  def change
    create_table :session_preferences do |t|
      t.references :user
      t.boolean :search_enabled

      t.timestamps
    end
    add_index :session_preferences, :user_id
  end
end
