require 'salva_controller_test'
require 'user_outreachwork_controller'

class UserOutreachworkController; def rescue_action(e) raise e end; end

class  UserOutreachworkControllerTest < SalvaControllerTest
  fixtures :userroles, :genericworkgroups, :genericworktypes, :genericworkstatuses, :genericworks, :user_genericworks  

  def initialize(*args)
   super
   @mycontroller =  UserOutreachworkController.new
   @myfixtures = { :genericwork_id => 1,  :user_id => 3,  :userrole_id => 1 }
   @mybadfixtures = { :genericwork_id => nil,  :user_id => 3,  :userrole_id => nil }
   @model = UserGenericwork
  end
end
