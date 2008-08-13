require 'salva_controller_test'
require 'roleincourse_controller'

class RoleincourseController; def rescue_action(e) raise e end; end

class  RoleincourseControllerTest < SalvaControllerTest
fixtures :roleincourses

  def initialize(*args)
   super
   @mycontroller =  RoleincourseController.new
   @myfixtures = {:name => 'ayudante'}
   @mybadfixtures = {:name => nil   }
   @model = Roleincourse
  end
end
