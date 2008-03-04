require  File.dirname(__FILE__) + '/salva_controller_test'
require 'identification_controller'

class IdentificationController; def rescue_action(e) raise e end; end

class  IdentificationControllerTest < SalvaControllerTest
  fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes,:institutions, :countries, :idtypes, :identifications

  def initialize(*args)
   super
   @mycontroller =  IdentificationController.new
   @myfixtures = {:idtype_id => 1,  :citizen_country_id => 804 }
   @mybadfixtures = { :idtype_id => nil,  :citizen_country_id => nil  }
   @model = Identification
   @quickposts =['idtype']
  end
end
