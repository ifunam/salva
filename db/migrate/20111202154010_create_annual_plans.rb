class CreateAnnualPlans < ActiveRecord::Migration
  def change
    create_table :annual_plans do |t|
      t.references :documenttype
      t.text :body
      t.references :user

      t.timestamps
    end
  end
end
