class AddImpactFactorToJournals < ActiveRecord::Migration
  def change
    add_column :journals, :impact_factor_id, :integer
  end
end
