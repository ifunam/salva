require 'salva_controller_test'
require 'country_controller'

class CountryController; def rescue_action(e) raise e end; end

class  CountryControllerTest < SalvaControllerTest
   fixtures :countries

  def initialize(*args)
   super
   @mycontroller =  CountryController.new
   @myfixtures = { :name => 'Myramar', :code => 'mr', :citizen => 'Myramaniano' }
   @mybadfixtures = {  :name => nil, :code => nil, :citizen => nil }
   @model = Country
  end
end
