require 'salva_controller_test'
require 'city_controller'

class CityControllerTest < SalvaControllerTest
    fixtures  :countries, :states, :cities

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = CityController.new
    @fixtures =  {:name => 'Bochil', :state_id => 9 }
    @badfixtures =  {:name =>nil, :state_id => 9 }
    @model = City
  end

end
