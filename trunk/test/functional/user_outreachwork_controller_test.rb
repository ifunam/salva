require 'salva_controller_test'
require 'user_outreachwork_controller'

class UserOutreachworkController; def rescue_action(e) raise e end; end

class  UserOutreachworkControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserOutreachworkController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserGenericwork
  end
end
