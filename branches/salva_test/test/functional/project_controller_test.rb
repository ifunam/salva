require 'salva_controller_test'
require 'project_controller'

class ProjectController; def rescue_action(e) raise e end; end

class  ProjectControllerTest < SalvaControllerTest
   fixtures :projecttypes,:projectstatuses,:projects

  def initialize(*args)
   super
   @mycontroller =  ProjectController.new
   @myfixtures = { :name => 'Seguridad Pública_test', :responsible => 'Alex Silva_test', :projecttype_id => 3, :descr => 'Verificar que todos den mordida_test', :startyear => 2007, :projectstatus_id => 3 }
   @mybadfixtures = {  :name => nil, :responsible => nil, :projecttype_id => nil, :descr => nil, :startyear => nil, :projectstatus_id => nil }
   @model = Project
  end
end
