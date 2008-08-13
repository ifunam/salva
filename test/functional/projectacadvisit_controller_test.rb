require 'salva_controller_test'
require 'projectacadvisit_controller'

class ProjectacadvisitController; def rescue_action(e) raise e end; end

class  ProjectacadvisitControllerTest < SalvaControllerTest
   fixtures :countries, :newspapers, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :projecttypes, :projectstatuses, :projects, :externalusers, :acadvisittypes, :acadvisits, :projectacadvisits

  def initialize(*args)
   super
   @mycontroller =  ProjectacadvisitController.new
   @myfixtures = { :project_id => 1, :acadvisit_id => 1 }
   @mybadfixtures = {  :project_id => nil, :acadvisit_id => nil }
   @model = Projectacadvisit
   @quickposts = [ 'acadvisit' ]
  end
end
