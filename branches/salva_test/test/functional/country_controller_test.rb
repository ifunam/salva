require 'salva_controller_test'
require 'country_controller'

class CountryControllerTest < SalvaControllerTest
    fixtures :countries

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = CountryController.new
    @fixtures =  { :name => 'País de prueba', :id => 999, :citizen=> 'Nacionalidad de prueba', :code =>'PRB' }
    @badfixtures =  {:name => nil, :id => 484, :citizen=> 'Mexicana', :code =>'MX' }
    @model = Country
  end

end
