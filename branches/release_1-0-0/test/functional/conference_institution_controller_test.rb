require 'salva_controller_test'
require 'conference_institution_controller'

class ConferenceInstitutionController; def rescue_action(e) raise e end; end

class  ConferenceInstitutionControllerTest < SalvaControllerTest
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :conferencetypes, :conferencescopes, :conferences, :conference_institutions

  def initialize(*args)
   super
   @mycontroller =  ConferenceInstitutionController.new
   @myfixtures = { :institution_id => 57, :conference_id => 2 }
   @mybadfixtures = {  :institution_id => nil, :conference_id => nil }
   @model = ConferenceInstitution
   @quickposts = [ 'conference' ]
  end
end
