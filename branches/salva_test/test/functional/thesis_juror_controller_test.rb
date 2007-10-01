require 'salva_controller_test'
require 'thesis_juror_controller'

class ThesisJurorController; def rescue_action(e) raise e end; end

class  ThesisJurorControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  ThesisJurorController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = ThesisJuror
  end
end
