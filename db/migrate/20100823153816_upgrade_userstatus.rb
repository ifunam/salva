class UpgradeUserstatus < ActiveRecord::Migration
  def self.up
    Userstatus.find(2).update_attributes(:name => 'Activo')
    Userstatus.find(1).update_attributes(:name => 'Baja - por defunción')
    Userstatus.find(3).update_attributes(:name => 'Baja - por renuncia')
    Userstatus.find(4).update_attributes(:name => 'Baja - por termino de contrato')
    Userstatus.find(5).update_attributes(:name => 'Inactivo')
  end

  def self.down
    
  end
end
