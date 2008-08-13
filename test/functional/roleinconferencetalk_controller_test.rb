require 'salva_controller_test'
require 'roleinconferencetalk_controller'

class RoleinconferencetalkController; def rescue_action(e) raise e end; end

class  RoleinconferencetalkControllerTest < SalvaControllerTest
fixtures :roleinconferencetalks

  def initialize(*args)
   super
   @mycontroller =  RoleinconferencetalkController.new
   @myfixtures = {:name => 'Cordinador'}
   @mybadfixtures = { :name => nil  }
   @model = Roleinconferencetalk
  end
end
