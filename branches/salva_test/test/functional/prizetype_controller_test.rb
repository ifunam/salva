require 'salva_controller_test'
require 'prizetype_controller'

class PrizetypeController; def rescue_action(e) raise e end; end

class  PrizetypeControllerTest < SalvaControllerTest
   fixtures :prizetypes

  def initialize(*args)
   super
   @mycontroller =  PrizetypeController.new
   @myfixtures = { :name => 'Medalla_test' }
   @mybadfixtures = {  :name => nil }
   @model = Prizetype
  end
end
