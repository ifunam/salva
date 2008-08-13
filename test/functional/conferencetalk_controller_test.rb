require 'salva_controller_test'
require 'conferencetalk_controller'

class ConferencetalkController; def rescue_action(e) raise e end; end

class  ConferencetalkControllerTest < SalvaControllerTest
fixtures :talkacceptances, :modalities, :talktypes, :conferencetypes, :conferencescopes, :countries,  :states, :conferences, :conferencetalks

  def initialize(*args)
   super
   @mycontroller =  ConferencetalkController.new
   @myfixtures = {:title => ' Estudios sobre formacion de barrancos en Martess', :authors => 'Imelda Martinez, Gerardo Hessman  conference_id: 1', :conference_id => 1 , :talktype_id => 2, :talkacceptance_id => 1, :modality_id => 1}
   @mybadfixtures = {:title => nil , :authors => nil,  :conference_id => 1, :talktype_id => 2, :talkacceptance_id => 1, :modality_id =>nil    }
   @model = Conferencetalk
   @quickpost = ['conference']
  end
end
