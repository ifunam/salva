require 'salva_controller_test'
require 'user_proceeding_controller'

class UserProceedingController; def rescue_action(e) raise e end; end

class  UserProceedingControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserProceedingController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserProceeding
  end
end
