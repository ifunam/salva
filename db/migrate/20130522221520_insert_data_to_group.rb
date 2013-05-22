class InsertDataToGroup < ActiveRecord::Migration
  def up
    Group.create(:name => 'admin', :descr => 'Administración del salva')
    Group.create(:name => 'default', :descr => 'Grupo predefinido')
    Group.create(:name => 'researcher', :descr => 'Investigadores')
    Group.create(:name => 'academic_technician', :descr => 'Técnicos académicos')
    Group.create(:name => 'administrative_staff', :descr => 'Secretaría académica y staff')
  end

  def down
    Group.destroy_all
  end
end
