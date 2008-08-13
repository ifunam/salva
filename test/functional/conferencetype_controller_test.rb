require 'salva_controller_test'
require 'conferencetype_controller'

class ConferencetypeController; def rescue_action(e) raise e end; end

class  ConferencetypeControllerTest < SalvaControllerTest
   fixtures :conferencetypes

  def initialize(*args)
   super
   @mycontroller =  ConferencetypeController.new
   @myfixtures = { :name => 'Congreso_test' }
   @mybadfixtures = {  :name => nil }
   @model = Conferencetype
  end
end
