require 'salva_controller_test'
require 'user_techreport_controller'

class UserTechreportController; def rescue_action(e) raise e end; end

class  UserTechreportControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserTechreportController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserGenericwork
  end
end
