require 'salva_controller_test'
require 'citizen_controller'

class CitizenController; def rescue_action(e) raise e end; end

class  CitizenControllerTest < SalvaControllerTest
   fixtures :countries, :migratorystatuses, :citizenmodalities, :citizens

  def initialize(*args)
   super
   @mycontroller =  CitizenController.new
   @myfixtures = { :migratorystatus_id => 2, :user_id => 2, :citizen_country_id => 484, :citizenmodality_id => 1 }
   @mybadfixtures = {  :migratorystatus_id => nil, :user_id => nil, :citizen_country_id => nil, :citizenmodality_id => nil }
   @model = Citizen
  end
end
