require 'salva_controller_test'
require 'has_many_keys_controller'

class HasManyKeysController; def rescue_action(e) raise e end; end

class  HasManyKeysControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  HasManyKeysController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = 
  end
end
