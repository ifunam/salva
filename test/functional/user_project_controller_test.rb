require 'salva_controller_test'
require 'user_project_controller'

class UserProjectController; def rescue_action(e) raise e end; end

class  UserProjectControllerTest < SalvaControllerTest
   fixtures  :projecttypes, :projectstatuses, :roleinprojects, :projects, :user_projects

  def initialize(*args)
   super
   @mycontroller =  UserProjectController.new
   @myfixtures = { :project_id => 2, :user_id => 2, :roleinproject_id => 1 }
   @mybadfixtures = {  :project_id => nil, :user_id => nil, :roleinproject_id => nil }
   @model = UserProject
   @quickposts = [ 'project' ]
  end
end
