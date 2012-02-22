# encoding: utf-8
class UpgradeUserstatus < ActiveRecord::Migration
  def self.up
    { 1 => 'Baja - por defunción', 2 => 'Activo', 3 => 'Baja - por renuncia',
      4 => 'Baja - por termino de contrato', 5 => 'Inactivo' }.each_pair do |id, value|
      if Userstatus.exists? id 
        Userstatus.find(id).update_attributes(:name => value)
      else
        Userstatus.create(:name => value)
      end

    end
    # Userstatus.find(2).update_attributes(:name => 'Activo')
    # Userstatus.find(1).update_attributes(:name => 'Baja - por defunción')
    # Userstatus.find(3).update_attributes(:name => 'Baja - por renuncia')
    # Userstatus.find(4).update_attributes(:name => 'Baja - por termino de contrato')
    # Userstatus.find(5).update_attributes(:name => 'Inactivo')
  end

  def self.down
    
  end
end
