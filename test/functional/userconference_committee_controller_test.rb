require 'salva_controller_test'
require 'userconference_committee_controller'

class UserconferenceCommitteeController; def rescue_action(e) raise e end; end

class  UserconferenceCommitteeControllerTest < SalvaControllerTest
   fixtures  :countries, :conferencetypes, :conferencescopes, :conferences, :roleinconferences, :userconferences

  def initialize(*args)
   super
   @mycontroller =  UserconferenceCommitteeController.new
   @myfixtures = { :roleinconference_id => 1, :conference_id => 1, :user_id => 2 }
   @mybadfixtures = {  :roleinconference_id => nil, :conference_id => nil, :user_id => nil }
   @model = Userconference
   @quickposts = [ 'conference,conference_id' ]
  end
end
