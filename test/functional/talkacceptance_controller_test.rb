require 'salva_controller_test'
require 'talkacceptance_controller'

class TalkacceptanceController; def rescue_action(e) raise e end; end

class  TalkacceptanceControllerTest < SalvaControllerTest
fixtures :talkacceptances

  def initialize(*args)
   super
   @mycontroller =  TalkacceptanceController.new
   @myfixtures = {:name => 'arbitrado_test'}
   @mybadfixtures = {:name => nil   }
   @model = Talkacceptance
  end
end
