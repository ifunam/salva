require 'salva_controller_test'
require 'techproducttype_controller'

class TechproducttypeController; def rescue_action(e) raise e end; end

class  TechproducttypeControllerTest < SalvaControllerTest
   fixtures :techproducttypes

  def initialize(*args)
   super
   @mycontroller =  TechproducttypeController.new
   @myfixtures = { :name => 'Videos_test' }
   @mybadfixtures = {  :name => nil }
   @model = Techproducttype
  end
end
