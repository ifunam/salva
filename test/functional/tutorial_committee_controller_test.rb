require 'salva_controller_test'
require 'tutorial_committee_controller'

class TutorialCommitteeController; def rescue_action(e) raise e end; end

class  TutorialCommitteeControllerTest < SalvaControllerTest
   fixtures :degrees, :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers, :tutorial_committees

  def initialize(*args)
   super
   @mycontroller =  TutorialCommitteeController.new
   @myfixtures = { :degree_id => 3, :institutioncareer_id => 2, :year => 2003, :user_id => 3, :studentname => 'Alejandro Silva_test' }
   @mybadfixtures = {  :degree_id => nil, :institutioncareer_id => nil, :year => nil, :user_id => nil, :studentname => nil }
   @model = TutorialCommittee
   @quickposts = [ 'institutioncareer' ]
  end
end
