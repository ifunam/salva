require 'salva_controller_test'
require 'researchline_controller'

class ResearchlineController; def rescue_action(e) raise e end; end

class  ResearchlineControllerTest < SalvaControllerTest
   fixtures :researchareas, :researchlines

  def initialize(*args)
   super
   @mycontroller =  ResearchlineController.new
   @myfixtures = { :name => 'Fuente sísmica_test' }
   @mybadfixtures = {  :name => nil }
   @model = Researchline
   @quickposts = [ 'researcharea' ]
  end
end
