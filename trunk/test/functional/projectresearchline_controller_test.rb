require 'salva_controller_test'
require 'projectresearchline_controller'

class ProjectresearchlineController; def rescue_action(e) raise e end; end

class  ProjectresearchlineControllerTest < SalvaControllerTest
   fixtures :projecttypes,:projectstatuses, :projects, :researchareas , :researchlines, :projectresearchlines

  def initialize(*args)
   super
   @mycontroller =  ProjectresearchlineController.new
   @myfixtures = { :researchline_id => 1, :project_id => 3 }
   @mybadfixtures = {  :researchline_id => nil, :project_id => nil }
   @model = Projectresearchline
   @quickposts = [ 'researchline' ]
  end
end
