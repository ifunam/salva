require 'salva_controller_test'
require 'institution_controller'

class InstitutionController; def rescue_action(e) raise e end; end

class  InstitutionControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions

  def initialize(*args)
   super
   @mycontroller =  InstitutionController.new
   @myfixtures = { :name => 'Dirección General de Asuntos del Personal Académico_test', :administrative_key => 55101, :country_id => 484, :institutiontitle_id => 14, :institutiontype_id => 1, :city_id => 1, :state_id => 9 }
   @mybadfixtures = {  :name => nil, :abbrev => nil, :administrative_key => nil, :zipcode => nil, :url => nil, :country_id => nil, :institution_id => nil, :phone => nil, :fax => nil, :institutiontitle_id => nil, :institutiontype_id => nil, :city_id => nil, :other => nil, :state_id => nil, :addr => nil }
   @model = Institution
   @quickposts = [ 'institutiontitle' ]
  end
end
