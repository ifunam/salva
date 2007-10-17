require 'salva_controller_test'
require 'user_researchline_controller'

class UserResearchlineController; def rescue_action(e) raise e end; end

class  UserResearchlineControllerTest < SalvaControllerTest
  fixtures :researchareas, :researchlines, :user_researchlines

  def initialize(*args)
   super
   @mycontroller =  UserResearchlineController.new
   @myfixtures = { :researchline_id => 3, :user_id => 2 }
   @mybadfixtures = {  :researchline_id => nil, :user_id => nil }
   @model = UserResearchline
   @quickposts = [ 'researcharea' ]
  end
end
