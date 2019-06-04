class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      #t.timestamps
    end
    execute "COMMENT ON TABLE buildings IS 'Edificios de ubicación de los usuarios'"
  end
end
