require 'salva_controller_test'
require 'user_language_controller'

class UserLanguageController; def rescue_action(e) raise e end; end

class  UserLanguageControllerTest < SalvaControllerTest
  fixtures :languages, :languagelevels, :institutions

  def initialize(*args)
   super
   @mycontroller =  UserLanguageController.new
   @myfixtures = { :language_id => 2, :spoken_languagelevel_id => 1, :written_languagelevel_id => 2, :institution_id => 71 }
    @mybadfixtures = { :language_id => nil, :spoken_languagelevel_id => nil, :written_languagelevel_id => nil, :institution_id => nil }
   @model = UserLanguage
#   @quickposts = ['institution']
  end
end
