class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user
      t.references :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
      t.references :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'
      t.references :document_type
      t.string :file
      t.timestamps
    end
  end
end
