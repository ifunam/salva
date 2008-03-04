require 'salva_controller_test'
require 'titlemodality_controller'

class TitlemodalityController; def rescue_action(e) raise e end; end

class  TitlemodalityControllerTest < SalvaControllerTest
   fixtures :titlemodalities

  def initialize(*args)
   super
   @mycontroller =  TitlemodalityController.new
   @myfixtures = { :name => 'Tesis_test' }
   @mybadfixtures = {  :name => nil }
   @model = Titlemodality
  end
end
