class CreateDepartmentHeads < ActiveRecord::Migration
  def up
    unless table_exists? :department_heads
      create_table :department_heads do |t|
        t.references :user, :null => false
        t.references :adscription, :null => false, :unique => true
        #t.timestamps
      end
      #add_index :department_heads, [:user_id, :adscription_id], unique: true
    end
    execute "COMMENT ON TABLE department_heads IS 'Jefes de departamento'"
  end

  def down
    drop_table :department_heads
  end
end
