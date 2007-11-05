require 'salva_controller_test'
require 'jobposition_at_institution_controller'

class JobpositionAtInstitutionController; def rescue_action(e) raise e end; end

class  JobpositionAtInstitutionControllerTest < SalvaControllerTest
 fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :jobpositionlevels, :roleinjobpositions, :jobpositiontypes, :jobpositioncategories,:contracttypes, :jobpositions  

  def initialize(*args)
   super
   @mycontroller =  JobpositionAtInstitutionController.new
   @myfixtures = { :contracttype_id => 2, :institution_id => 30,:jobpositioncategory_id => 1,:startyear => 1998, :endyear => 2000}
   @mybadfixtures = {  :institution_id => nil, :jobpositioncategory_id => 1,:startyear => nil, :endyear => nil}
   @model = JobpositionAtInstitution
  end
end
