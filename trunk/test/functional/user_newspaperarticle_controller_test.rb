require 'salva_controller_test'
require 'user_newspaperarticle_controller'

class UserNewspaperarticleController; def rescue_action(e) raise e end; end

class  UserNewspaperarticleControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserNewspaperarticleController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserNewspaperarticle
  end
end
