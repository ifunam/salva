require 'salva_controller_test'
require 'student_thesis_controller'

class StudentThesisController; def rescue_action(e) raise e end; end

class  StudentThesisControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  StudentThesisController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserThesis
  end
end
