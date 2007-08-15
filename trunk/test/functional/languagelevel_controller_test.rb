require 'salva_controller_test'
require 'languagelevel_controller'

class LanguagelevelController; def rescue_action(e) raise e end; end

class  LanguagelevelControllerTest < SalvaControllerTest
   fixtures :languagelevels

  def initialize(*args)
   super
   @mycontroller =  LanguagelevelController.new
   @myfixtures = { :name => 'Intermedio_test' }
   @mybadfixtures = {  :name => nil }
   @model = Languagelevel
  end
end
