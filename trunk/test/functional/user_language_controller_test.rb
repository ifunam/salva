require 'salva_controller_test'
require 'user_language_controller'

class UserLanguageController; def rescue_action(e) raise e end; end

class  UserLanguageControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserLanguageController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserLanguage
   @quickposts = []
  end
end
