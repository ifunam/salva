require 'salva_controller_test'
require 'roleinregularcourse_controller'

class RoleinregularcourseController; def rescue_action(e) raise e end; end

class  RoleinregularcourseControllerTest < SalvaControllerTest
   fixtures :roleinregularcourses

  def initialize(*args)
   super
   @mycontroller =  RoleinregularcourseController.new
   @myfixtures = { :name => 'Titular_test' }
   @mybadfixtures = {  :name => nil }
   @model = Roleinregularcourse
  end
end
