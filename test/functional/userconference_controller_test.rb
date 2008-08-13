require 'salva_controller_test'
require 'userconference_controller'

class UserconferenceController; def rescue_action(e) raise e end; end

class  UserconferenceControllerTest < SalvaControllerTest
   fixtures  :countries, :conferencetypes, :conferencescopes, :conferences, :roleinconferences, :userconferences

  def initialize(*args)
   super
   @mycontroller =  UserconferenceController.new
   @myfixtures = { :roleinconference_id => 1, :conference_id => 1, :user_id => 2 }
   @mybadfixtures = {  :roleinconference_id => nil, :conference_id => nil, :user_id => nil }
   @model = Userconference
  end
end
