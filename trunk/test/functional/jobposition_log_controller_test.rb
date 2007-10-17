require 'salva_controller_test'
require 'jobposition_log_controller'

class JobpositionLogController; def rescue_action(e) raise e end; end

class  JobpositionLogControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  JobpositionLogController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = JobpositionLog
  end
end
