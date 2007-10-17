require 'salva_controller_test'
require 'indivadvicetarget_controller'

class IndivadvicetargetController; def rescue_action(e) raise e end; end

class  IndivadvicetargetControllerTest < SalvaControllerTest
   fixtures :indivadvicetargets

  def initialize(*args)
   super
   @mycontroller =  IndivadvicetargetController.new
   @myfixtures = { :name => 'Estudiante asociado_test' }
   @mybadfixtures = {  :name => nil }
   @model = Indivadvicetarget
  end
end
