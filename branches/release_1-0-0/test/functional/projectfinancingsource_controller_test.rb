require 'salva_controller_test'
require 'projectfinancingsource_controller'

class ProjectfinancingsourceController; def rescue_action(e) raise e end; end

class  ProjectfinancingsourceControllerTest < SalvaControllerTest
   fixtures :projecttypes,:projectstatuses, :projects, :countries,  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :projectfinancingsources

  def initialize(*args)
   super
   @mycontroller =  ProjectfinancingsourceController.new
   @myfixtures = { :project_id => 2, :institution_id => 1, :amount => 150000 }
   @mybadfixtures = {  :project_id => nil, :institution_id => nil, :amount => nil }
   @model = Projectfinancingsource
  end
end
