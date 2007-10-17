require 'salva_controller_test'
require 'talktype_controller'

class TalktypeController; def rescue_action(e) raise e end; end

class  TalktypeControllerTest < SalvaControllerTest
fixtures :talktypes

  def initialize(*args)
   super
   @mycontroller =  TalktypeController.new
   @myfixtures = {:name =>'platicas_test'}
   @mybadfixtures = {:name => nil   }
   @model = Talktype
  end
end
