require 'salva_controller_test'
require 'institution_controller'

class Institution_Controller_Test < SalvaControllerTest
  fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = InstitutionController.new
    @myfixtures =  {
    :name => 'Direccion general asuntos academicos', :administrative_key => 55101, :country_id =>484, :city_id => 1, :institutiontitle_id => 14, :institutiontype_id => 1,
    :state_id=> 9 , :id=> 1}


    @mybadfixtures = {
    :name => nil, :administrative_key => 55101, :country_id =>nil, :city_id => 1, :institutiontitle_id => 14, :institutiontype_id => 1,
    :state_id=> nil, :id => nil}
     @class = Institution

  end
end
