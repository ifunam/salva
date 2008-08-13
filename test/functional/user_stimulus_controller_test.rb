require 'salva_controller_test'
require 'user_stimulus_controller'

class UserStimulusController; def rescue_action(e) raise e end; end

class  UserStimulusControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  UserStimulusController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserStimulus
  end
end
