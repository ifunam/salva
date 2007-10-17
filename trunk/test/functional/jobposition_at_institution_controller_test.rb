require 'salva_controller_test'
require 'jobposition_at_institution_controller'

class JobpositionAtInstitutionController; def rescue_action(e) raise e end; end

class  JobpositionAtInstitutionControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  JobpositionAtInstitutionController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = JobpositionAtInstitution
  end
end
