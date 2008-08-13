require 'salva_controller_test'
require 'projectinstitution_controller'

class ProjectinstitutionController; def rescue_action(e) raise e end; end

class  ProjectinstitutionControllerTest < SalvaControllerTest
   fixtures :projecttypes,:projectstatuses, :projects, :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :projectinstitutions

  def initialize(*args)
   super
   @mycontroller =  ProjectinstitutionController.new
   @myfixtures = { :project_id => 1, :institution_id => 1 }
   @mybadfixtures = {  :project_id => nil, :institution_id => nil }
   @model = Projectinstitution
  end
end
