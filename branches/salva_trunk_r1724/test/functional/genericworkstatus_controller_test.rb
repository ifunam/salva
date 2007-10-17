require 'salva_controller_test'
require 'genericworkstatus_controller'

class GenericworkstatusController; def rescue_action(e) raise e end; end

class  GenericworkstatusControllerTest < SalvaControllerTest
   fixtures :genericworkstatuses

  def initialize(*args)
   super
   @mycontroller =  GenericworkstatusController.new
   @myfixtures = { :name => 'Propuesto_test' }
   @mybadfixtures = {  :name => nil }
   @model = Genericworkstatus
  end
end
