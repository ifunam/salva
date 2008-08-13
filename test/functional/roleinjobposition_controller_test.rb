require 'salva_controller_test'
require 'roleinjobposition_controller'

class RoleinjobpositionController; def rescue_action(e) raise e end; end

class  RoleinjobpositionControllerTest < SalvaControllerTest
  fixtures :roleinjobpositions

  def initialize(*args)
   super
   @mycontroller =  RoleinjobpositionController.new
   @myfixtures = {:name => 'pasnte investigador'}
   @mybadfixtures = {:name => nil   }
   @model = Roleinjobposition
  end
end
