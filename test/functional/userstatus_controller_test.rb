require 'salva_controller_test'
require 'userstatus_controller'

class UserstatusController; def rescue_action(e) raise e end; end

class  UserstatusControllerTest < SalvaControllerTest
   fixtures :userstatuses

  def initialize(*args)
   super
   @mycontroller =  UserstatusController.new
   @myfixtures = { :name => 'Nuevo_test' }
   @mybadfixtures = {  :name => nil }
   @model = Userstatus
  end
end
