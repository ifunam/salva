require 'salva_controller_test'
require 'user_genericwork_controller'

class UserGenericworkController; def rescue_action(e) raise e end; end

class  UserGenericworkControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserGenericworkController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserGenericwork
  end
end
