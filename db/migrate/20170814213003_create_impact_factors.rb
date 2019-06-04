class CreateImpactFactors < ActiveRecord::Migration
  def change
    create_table :impact_factors do |t|
      t.references :journal, :class_name => 'Journal', :foreign_key => 'journal_id', :null => false
      t.integer :year, :limit => 2, :null => false
      t.float :value, :null => false
      #t.timestamps
    end
    add_index :impact_factors, [:journal_id, :year], unique: true
    execute "COMMENT ON TABLE impact_factors IS 'Factor de impacto por revista y por a~no'"
  end
end
