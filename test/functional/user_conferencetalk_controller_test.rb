require 'salva_controller_test'
require 'user_conferencetalk_controller'

class UserConferencetalkController; def rescue_action(e) raise e end; end

class  UserConferencetalkControllerTest < SalvaControllerTest
   fixtures  :roleinconferences, :roleinconferencetalks, :countries, :conferencetypes, :conferencescopes, :talkacceptances, :modalities, :talktypes, :conferences, :conferencetalks, :user_conferencetalks

  def initialize(*args)
   super
   @mycontroller =  UserConferencetalkController.new
   @myfixtures = { :roleinconferencetalk_id => 2, :user_id => 3 }
   @mybadfixtures = {  :roleinconferencetalk_id => nil, :user_id => nil }
   @model = UserConferencetalk
   @quickposts = [ 'conferencetalk' ]
  end
end
