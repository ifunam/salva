require 'salva_controller_test'
require 'researcharea_controller'

class ResearchareaController; def rescue_action(e) raise e end; end

class  ResearchareaControllerTest < SalvaControllerTest
   fixtures :researchareas

  def initialize(*args)
   super
   @mycontroller =  ResearchareaController.new
   @myfixtures = { :name => 'Transferencia de Radiación_test' }
   @mybadfixtures = {  :name => nil }
   @model = Researcharea
  end
end
