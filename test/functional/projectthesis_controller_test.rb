require 'salva_controller_test'
require 'projectthesis_controller'

class ProjectthesisController; def rescue_action(e) raise e end; end

class  ProjectthesisControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  ProjectthesisController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = Projectthesis
  end
end
