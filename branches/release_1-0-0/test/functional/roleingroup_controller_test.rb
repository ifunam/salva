require 'salva_controller_test'
require 'roleingroup_controller'

class RoleingroupController; def rescue_action(e) raise e end; end

class  RoleingroupControllerTest < SalvaControllerTest
   fixtures :groups, :roles, :roleingroups

  def initialize(*args)
   super
   @mycontroller =  RoleingroupController.new
   @myfixtures = { :role_id => 1, :group_id => 1 }
   @mybadfixtures = {  :role_id => nil, :group_id => nil }
   @model = Roleingroup
   @quickposts = [ 'role' ]
  end
end
