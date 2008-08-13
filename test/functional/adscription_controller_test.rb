require 'salva_controller_test'
require 'adscription_controller'

class AdscriptionController; def rescue_action(e) raise e end; end

class  AdscriptionControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions,  :adscriptions

  def initialize(*args)
   super
   @mycontroller =  AdscriptionController.new
   @myfixtures = { :name => 'Contaminación ambiental_test', :institution_id => 57 }
   @mybadfixtures = {  :created_on => nil, :name => nil, :descr => nil, :abbrev => nil, :moduser_id => nil, :updated_on => nil, :administrative_key => nil, :institution_id => nil }
   @model = Adscription
  end
end
