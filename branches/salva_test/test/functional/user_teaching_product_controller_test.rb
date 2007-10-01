require 'salva_controller_test'
require 'user_teaching_product_controller'

class UserTeachingProductController; def rescue_action(e) raise e end; end

class  UserTeachingProductControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserTeachingProductController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserGenericwork
  end
end
