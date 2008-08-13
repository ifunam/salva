require 'salva_controller_test'
require 'user_thesis_controller'

class UserThesisController; def rescue_action(e) raise e end; end

class  UserThesisControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserThesisController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserThesis
  end
end
