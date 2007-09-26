require 'salva_controller_test'
require 'user_language_controller'

class UserLanguageController; def rescue_action(e) raise e end; end

class  UserLanguageControllerTest < SalvaControllerTest
  fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :languages, :languagelevels, :user_languages

  def initialize(*args)
   super
   @mycontroller =  UserLanguageController.new
   @myfixtures = { :language_id => 1, :spoken_languagelevel_id => 1, :written_languagelevel_id => 1, :institution_id => 57 }
    @mybadfixtures = { :language_id => nil, :spoken_languagelevel_id => nil, :written_languagelevel_id => nil, :institution_id => nil }
   @model = UserLanguage
   @quickposts = ['institution']
  end
end
