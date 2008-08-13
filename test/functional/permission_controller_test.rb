require 'salva_controller_test'
require 'permission_controller'

class PermissionController; def rescue_action(e) raise e end; end

class  PermissionControllerTest < SalvaControllerTest
   fixtures  :actions, :groups, :roles, :roleingroups, :controllers, :permissions

  def initialize(*args)
   super
   @mycontroller =  PermissionController.new
   @myfixtures = { :roleingroup_id => 1, :action_id => 3, :controller_id => 3 }
   @mybadfixtures = {  :roleingroup_id => nil, :action_id => nil, :controller_id => nil }
   @model = Permission
  end
end
