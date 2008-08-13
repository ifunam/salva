require 'salva_controller_test'
require 'user_popularsciencework_controller'

class UserPopularscienceworkController; def rescue_action(e) raise e end; end

class  UserPopularscienceworkControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserPopularscienceworkController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserGenericwork
  end
end
