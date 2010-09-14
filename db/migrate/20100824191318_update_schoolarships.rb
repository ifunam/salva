class UpdateSchoolarships < ActiveRecord::Migration
  def self.up
    Schoolarship.create(:name => 'Beca Directa', :institution_id => 96)
    Schoolarship.create(:name => 'Beca Directa', :institution_id => 5453)
    Schoolarship.create(:name => 'Beca por Proyecto', :institution_id => 96)
    Schoolarship.create(:name => 'Beca por Proyecto', :institution_id => 5453)
    Schoolarship.create(:name => 'Ingresos Extraordinarios', :institution_id => 1)
    Schoolarship.create(:name => 'Otra')
  end
  
  def self.down
    Schoolarship.where(:name => 'Beca Directa', :institution_id => 96).all.each {|record| record.destroy }
    Schoolarship.where(:name => 'Beca Directa', :institution_id => 5453).all.each {|record| record.destroy }
    Schoolarship.where(:name => 'Beca por proyecto', :institution_id => 30).all.each {|record| record.destroy }
    Schoolarship.where(:name => 'Ingresos Extraordinarios', :institution_id => 30).all.each {|record| record.destroy }
    Schoolarship.where(:name => 'Otra').all.each {|record| record.destroy }
  end
end
