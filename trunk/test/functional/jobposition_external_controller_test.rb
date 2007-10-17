require 'salva_controller_test'
require 'jobposition_external_controller'

class JobpositionExternalController; def rescue_action(e) raise e end; end

class  JobpositionExternalControllerTest < SalvaControllerTest
   fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :jobpositions

  def initialize(*args)
   super
   @mycontroller =  JobpositionExternalController.new
   @myfixtures = { :startyear => 1998, :institution_id => 1, :user_id => 2 }
   @mybadfixtures = {  :startyear => nil, :institution_id => nil, :user_id => nil }
   @model = Jobposition
   @quickposts = [ 'institution' ]
  end
end
