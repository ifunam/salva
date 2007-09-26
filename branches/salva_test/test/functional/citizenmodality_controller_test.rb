require 'salva_controller_test'
require 'citizenmodality_controller'

class CitizenmodalityController; def rescue_action(e) raise e end; end

class  CitizenmodalityControllerTest < SalvaControllerTest
fixtures :citizenmodalities

  def initialize(*args)
   super
   @mycontroller =  CitizenmodalityController.new
   @myfixtures = {:name =>'otros'}
   @mybadfixtures = {:name => nil }
   @model = Citizenmodality
  end
end
