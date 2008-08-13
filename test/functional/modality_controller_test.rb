require 'salva_controller_test'
require 'modality_controller'

class ModalityController; def rescue_action(e) raise e end; end

class  ModalityControllerTest < SalvaControllerTest
   fixtures :modalities

  def initialize(*args)
   super
   @mycontroller =  ModalityController.new
   @myfixtures = { :name => 'Presencial y a Distancia_test' }
   @mybadfixtures = {  :name => nil }
   @model = Modality
  end
end
