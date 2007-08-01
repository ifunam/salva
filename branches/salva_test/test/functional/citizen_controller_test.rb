
require 'salva_controller_test'
require 'citizen_controller'

class Citizen_ControllerTest < SalvaControllerTest
  fixtures :users, :countries, :migratorystatuses, :citizenmodalities, :citizens

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = CitizenController.new
    @myfixtures =  {
      :migratorystatus_id => 1, :citizen_country_id =>484,  :citizenmodality_id => 2,  :migratorystaus_id  => 2
    }
    @mybadfixtures ={
     :migratorystatus_id => nil, :citizen_country_id =>484,  :citizenmodality_id => 1,  :migratorystaus_id  => 1
     }
    #puts @myfixtures
  end

end
