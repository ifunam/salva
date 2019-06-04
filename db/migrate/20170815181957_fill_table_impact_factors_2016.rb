class FillTableImpactFactors2016 < ActiveRecord::Migration
  def up
    year = 2016
    journals = Journal.where("impact_index is not null")
    journals.each do |j|
      puts "Insertando en el factor de impacto: #{j[:id]}, #{year}, #{j[:impact_index]}"
      execute "INSERT INTO impact_factors ( journal_id, year, value ) VALUES ( #{j[:id]}, #{year}, #{j[:impact_index]} )"
    end
  end

  def down
  end
end
