require 'salva_controller_test'
require 'acadvisittype_controller'

class AcadvisittypeController; def rescue_action(e) raise e end; end

class  AcadvisittypeControllerTest < SalvaControllerTest
   fixtures :acadvisittypes

  def initialize(*args)
   super
   @mycontroller =  AcadvisittypeController.new
   @myfixtures = { :name => 'Posdoctoral_test' }
   @mybadfixtures = {  :name => nil }
   @model = Acadvisittype
  end
end
