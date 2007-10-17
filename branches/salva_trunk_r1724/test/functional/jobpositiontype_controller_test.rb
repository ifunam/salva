require 'salva_controller_test'
require 'jobpositiontype_controller'

class JobpositiontypeController; def rescue_action(e) raise e end; end

class  JobpositiontypeControllerTest < SalvaControllerTest
  fixtures :jobpositiontypes

  def initialize(*args)
   super
   @mycontroller =  JobpositiontypeController.new
   @myfixtures = {:name => 'Personales académicos para docenciasssss' }
   @mybadfixtures = {:name => nil   }
   @model = Jobpositiontype
  end
end
