require 'salva_controller_test'
require 'roleproceeding_controller'

class RoleproceedingController; def rescue_action(e) raise e end; end

class  RoleproceedingControllerTest < SalvaControllerTest
   fixtures :roleproceedings

  def initialize(*args)
   super
   @mycontroller =  RoleproceedingController.new
   @myfixtures = { :name => 'Arbitro_test' }
   @mybadfixtures = {  :name => nil }
   @model = Roleproceeding
  end
end
