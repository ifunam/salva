class CreateUserAdscriptionRecords < ActiveRecord::Migration
  def change
    create_table :user_adscription_records do |t|
      t.references :user, :class_name => 'User', :foreign_key => 'user_id', :null => false
      t.references :adscription, :class_name => 'Adscription', :foreign_key => 'adscription_id', :null => false
      t.references :jobposition, :class_name => 'Jobposition', :foreign_key => 'jobposition_id', :null => false
      t.integer :year, :limit => 2, :null => false

      #t.timestamps
    end
    execute "COMMENT ON TABLE user_adscription_records IS 'Historial de adscripciones para los usuarios'"
  end
end
