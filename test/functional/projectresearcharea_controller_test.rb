require 'salva_controller_test'
require 'projectresearcharea_controller'

class ProjectresearchareaController; def rescue_action(e) raise e end; end

class  ProjectresearchareaControllerTest < SalvaControllerTest
   fixtures :projecttypes,:projectstatuses, :projects, :researchareas, :projectresearchareas

  def initialize(*args)
   super
   @mycontroller =  ProjectresearchareaController.new
   @myfixtures = { :researcharea_id => 1, :project_id => 1 }
   @mybadfixtures = {  :researcharea_id => nil, :project_id => nil }
   @model = Projectresearcharea
   @quickposts = [ 'researcharea' ]
  end
end
