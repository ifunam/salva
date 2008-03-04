require 'salva_controller_test'
require 'projectgenericwork_controller'

class ProjectgenericworkController; def rescue_action(e) raise e end; end

class  ProjectgenericworkControllerTest < SalvaControllerTest
   fixtures :projecttypes,:projectstatuses, :projects, :genericworkstatuses, :genericworkgroups, :genericworktypes, :genericworks, :projectgenericworks

  def initialize(*args)
   super
   @mycontroller =  ProjectgenericworkController.new
   @myfixtures = { :genericwork_id => 2, :project_id => 2 }
   @mybadfixtures = {  :genericwork_id => nil, :project_id => nil }
   @model = Projectgenericwork
   @quickposts = [ 'genericwork' ]
  end
end
