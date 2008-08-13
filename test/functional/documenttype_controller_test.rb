require 'salva_controller_test'
require 'documenttype_controller'

class DocumenttypeController; def rescue_action(e) raise e end; end

class  DocumenttypeControllerTest < SalvaControllerTestx
  fixtures :documenttypes

  def initialize(*args)
   super
   @mycontroller =  DocumenttypeController.new
   @myfixtures = { :name => 'Otro pinche informe' }
   @mybadfixtures = {  :name => nil }
   @model = Documenttype
  end
end
