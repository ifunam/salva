require 'salva_controller_test'
require 'user_adscription_controller'

class UserAdscriptionController; def rescue_action(e) raise e end; end

class  UserAdscriptionControllerTest < SalvaControllerTest
fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :adscriptions, :jobpositions,:user_adscriptions

  def initialize(*args)
   super
   @mycontroller =  UserAdscriptionController.new
   @myfixtures = {:jobposition_id => 2, :adscription_id => 1, :startyear => 2000 }
   @mybadfixtures = {:jobposition_id => nil, :adscription_id => 1, :startyear => nil  }
   @model = UserAdscription
   @quickposts = ['jobposition_at_institution']
  end
end
