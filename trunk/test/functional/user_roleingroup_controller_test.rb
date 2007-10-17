require 'salva_controller_test'
require 'user_roleingroup_controller'

class UserRoleingroupController; def rescue_action(e) raise e end; end

class  UserRoleingroupControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserRoleingroupController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserRoleingroup
  end
end
