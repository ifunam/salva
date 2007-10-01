require 'salva_controller_test'
require 'people_identification_controller'

class PeopleIdentificationController; def rescue_action(e) raise e end; end

class  PeopleIdentificationControllerTest < SalvaControllerTest
   fixtures :countries, :idtypes, :identifications, :people_identifications

  def initialize(*args)
   super
   @mycontroller =  PeopleIdentificationController.new
   @myfixtures = { :descr => 'Credencial de Elector Mexicana_test', :identification_id => 2, :user_id => 3 }
   @mybadfixtures = {  :descr => nil, :identification_id => nil, :user_id => nil }
   @model = PeopleIdentification
   @quickposts = [ 'identification' ]
  end
end
