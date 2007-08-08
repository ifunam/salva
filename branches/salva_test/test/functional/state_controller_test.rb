require 'salva_controller_test'
require 'city_controller'

class StateControllerTest < SalvaControllerTest
    fixtures :countries, :states

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = StateController.new
    @fixtures =  { :name => 'Oaxaca', :country_id => 484,  :code =>'OAX'}
    @badfixtures =  {:name => nil, :country_id => 484,  :code =>'OAX', }
    @model = State
  end
end
