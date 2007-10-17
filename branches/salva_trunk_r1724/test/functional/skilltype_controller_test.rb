require 'salva_controller_test'
require 'skilltype_controller'

class SkilltypeController; def rescue_action(e) raise e end; end

class  SkilltypeControllerTest < SalvaControllerTest
   fixtures :skilltypes

  def initialize(*args)
   super
   @mycontroller =  SkilltypeController.new
   @myfixtures = { :name => 'Para comer galletitas_test' }
   @mybadfixtures = {  :name => nil }
   @model = Skilltype
  end
end
