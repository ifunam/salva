require 'salva_controller_test'
require 'acadvisit_controller'

class AcadvisitController; def rescue_action(e) raise e end; end

class  AcadvisitControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions,:acadvisittypes, :acadvisits

  def initialize(*args)
   super
   @mycontroller =  AcadvisitController.new
   @myfixtures = { :descr => 'Estancia de investigación en los alpes_test', :startyear => 2007, :acadvisittype_id => 1, :country_id => 392, :institution_id => 1, :user_id => 1 }
   @mybadfixtures = {  :descr => nil, :startyear => nil, :acadvisittype_id => nil, :country_id => nil, :institution_id => nil, :user_id => nil }
   @model = Acadvisit
  end
end
