require 'salva_controller_test'
require 'idtype_controller'

class IdtypeController; def rescue_action(e) raise e end; end

class  IdtypeControllerTest < SalvaControllerTest
   fixtures :idtypes

  def initialize(*args)
   super
   @mycontroller =  IdtypeController.new
   @myfixtures = { :name => 'RFC_test' }
   @mybadfixtures = {  :name => nil }
   @model = Idtype
  end
end
