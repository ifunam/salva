require 'salva_controller_test'
require 'contracttype_controller'

class ContracttypeController; def rescue_action(e) raise e end; end

class  ContracttypeControllerTest < SalvaControllerTest
fixtures :contracttypes

  def initialize(*args)
   super
   @mycontroller =  ContracttypeController.new
   @myfixtures = {:name => 'plaza temporal'}
   @mybadfixtures = { :name => nil  }
   @model = Contracttype
  end
end
