require 'salva_controller_test'
require 'city_controller'

class CityController; def rescue_action(e) raise e end; end

class  CityControllerTest < SalvaControllerTest
   fixtures  :countries, :states, :cities

  def initialize(*args)
   super
   @mycontroller =  CityController.new
   @myfixtures = { :name => 'Culiacán_test', :state_id => 25 }
   @mybadfixtures = {  :name => nil, :state_id => nil }
   @model = City
  end
end
