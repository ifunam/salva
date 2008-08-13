require 'salva_controller_test'
require 'institutional_activity_controller'

class InstitutionalActivityController; def rescue_action(e) raise e end; end

class  InstitutionalActivityControllerTest < SalvaControllerTest
fixtures   :countries, :states, :cities, :users,  :institutiontitles, :institutiontypes, :institutions, :institutional_activities

  def initialize(*args)
   super
   @mycontroller =  InstitutionalActivityController.new
   @myfixtures =  {:user_id => 3 , :descr =>'revocacion de plazas de trabajo', :institution_id => 1, :startyear => 2006}
   @mybadfixtures = {:user_id => 3 , :descr =>nil, :institution_id => nil, :startyear => 2006}
   @model = InstitutionalActivity
  end
end
