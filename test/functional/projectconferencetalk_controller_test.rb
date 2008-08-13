require 'salva_controller_test'
require 'projectconferencetalk_controller'

class ProjectconferencetalkController; def rescue_action(e) raise e end; end

class  ProjectconferencetalkControllerTest < SalvaControllerTest
   fixtures :projecttypes,:projectstatuses, :projects, :countries, :conferencetypes, :conferencescopes, :conferences, :talktypes, :talkacceptances, :modalities, :conferencetalks, :projectconferencetalks

  def initialize(*args)
   super
   @mycontroller =  ProjectconferencetalkController.new
   @myfixtures = { :project_id => 3, :conferencetalk_id => 2 }
   @mybadfixtures = {  :project_id => nil, :conferencetalk_id => nil }
   @model = Projectconferencetalk
   @quickposts = [ 'conferencetalk' ]
  end
end
