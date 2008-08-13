require 'salva_controller_test'
require 'controllers_controller'

class ControllersController; def rescue_action(e) raise e end; end

class  ControllersControllerTest < SalvaControllerTest
   fixtures :controllers

  def initialize(*args)
   super
   @mycontroller =  ControllersController.new
   @myfixtures = { :name => 'citizen_test' }
   @mybadfixtures = {  :name => nil }
   @model = Controller
  end
end
