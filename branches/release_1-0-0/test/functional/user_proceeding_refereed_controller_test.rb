require 'salva_controller_test'
require 'user_proceeding_refereed_controller'

class UserProceedingRefereedController; def rescue_action(e) raise e end; end

class  UserProceedingRefereedControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserProceedingRefereedController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserProceeding
  end
end
