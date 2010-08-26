class UpdateSchoolarships < ActiveRecord::Migration
  def self.up
    Schoolarship.create(:name => 'Beca Directa', :institution_id => 96)
    Schoolarship.create(:name => 'Beca Directa', :institution_id => 5453)
    Schoolarship.create(:name => 'Beca por proyecto', :institution_id => 30)
    Schoolarship.create(:name => 'Ingresos Extraordinarios', :institution_id => 30)
    Schoolarship.create(:name => 'Otra', :institution_id => 1)
  end
  
  def self.down
  end
end
