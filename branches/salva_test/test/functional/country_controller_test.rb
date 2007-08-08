require 'salva_controller_test'
require 'country_controller'

class CountryControllerTest < SalvaControllerTest
    fixtures :countries

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = CountryController.new
    @fixtures =  { :name => 'Mexico', :id => 484, :citizen=> 'Mexicana', :code =>'MX' }
    @badfixtures =  {:name => nil, :id => 484, :citizen=> 'Mexicana', :code =>'MX' }
    @model = Country
  end

end
