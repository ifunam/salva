require 'salva_controller_test'
require 'state_controller'

class StateController; def rescue_action(e) raise e end; end

class  StateControllerTest < SalvaControllerTest
   fixtures :countries, :states

  def initialize(*args)
   super
   @mycontroller =  StateController.new
   @myfixtures = { :name => 'Nuevo León_test', :country_id => 484 }
   @mybadfixtures = {  :name => nil, :code => nil, :country_id => nil }
   @model = State
  end
end
