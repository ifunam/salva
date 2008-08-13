require 'salva_controller_test'
require 'career_controller'

class CareerController; def rescue_action(e) raise e end; end

class  CareerControllerTest < SalvaControllerTest
   fixtures :degrees, :careers

  def initialize(*args)
   super
   @mycontroller =  CareerController.new
   @myfixtures = { :name => 'Actuaria_test', :degree_id => 3 }
   @mybadfixtures = {  :name => nil, :degree_id => nil }
   @model = Career
  end
end
