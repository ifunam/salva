require 'salva_controller_test'
require 'language_controller'

class LanguageController; def rescue_action(e) raise e end; end

class  LanguageControllerTest < SalvaControllerTest
   fixtures :languages

  def initialize(*args)
   super
   @mycontroller =  LanguageController.new
   @myfixtures = { :name => 'Español_test' }
   @mybadfixtures = {  :name => nil }
   @model = Language
  end
end
