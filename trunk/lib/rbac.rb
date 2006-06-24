module Rbac
  def rbac_required
    roles = UserRoleingroup.find_by_user_id(session[:user])
   
    unless check_permission(roles, controller_name, 
                            action_name)
      access_denied and return false 
    end
  end
  
  def check_permission(rol,controller_name,action_name)
    #roles.each { | rol |
    controller = Controller.find_by_name(controller_name)
    action = Action.find_by_name(action_name)
      permission = Permission.find(:first, :conditions => ['roleingroup_id = ? AND controller_id = ? AND action_id = ?', rol.id, controller.id, action.id ])
    return true if permission
    #}
  end
end

