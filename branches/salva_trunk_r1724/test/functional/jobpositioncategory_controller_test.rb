require 'salva_controller_test'
require 'jobpositioncategory_controller'

class JobpositioncategoryController; def rescue_action(e) raise e end; end

class  JobpositioncategoryControllerTest < SalvaControllerTest
fixtures :jobpositiontypes, :roleinjobpositions, :jobpositionlevels, :jobpositioncategories

  def initialize(*args)
   super
   @mycontroller =  JobpositioncategoryController.new
   @myfixtures = {  :jobpositiontype_id => 2, :roleinjobposition_id => 3,  :jobpositionlevel_id => 1}
   @mybadfixtures = {  :jobpositiontype_id => nil, :roleinjobposition_id => 3,  :jobpositionlevel_id => nil  }
   @model = Jobpositioncategory
   @quickposts = ['jobpositiontype', 'roleinjobposition', 'jobpositionlevel']
  end
end
