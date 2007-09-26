require 'salva_controller_test'
require 'jobpositionlevel_controller'

class JobpositionlevelController; def rescue_action(e) raise e end; end

class  JobpositionlevelControllerTest < SalvaControllerTest
  fixtures :jobpositionlevels

  def initialize(*args)
   super
   @mycontroller =  JobpositionlevelController.new
   @myfixtures =  { :name => 'Asociados Amt'}
   @mybadfixtures = { :name => nil  }
   @model = Jobpositionlevel
  end
end
