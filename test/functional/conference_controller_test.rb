require 'salva_controller_test'
require 'conference_controller'

class ConferenceController; def rescue_action(e) raise e end; end

class  ConferenceControllerTest < SalvaControllerTest
   fixtures  :countries, :conferencetypes, :conferencescopes, :conferences

  def initialize(*args)
   super
   @mycontroller =  ConferenceController.new
   @myfixtures = { :name => 'Congreso Anual de Ciencias de la Computación_test', :country_id => 484, :conferencetype_id => 1, :conferencescope_id => 1, :year => 1998 }
   @mybadfixtures = {  :name => nil, :country_id => nil, :conferencetype_id => nil, :conferencescope_id => nil, :year => nil }
   @model = Conference
  end
end
