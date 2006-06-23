module Rbac
  def rbac_required
    roles = UserRoleingroup.find_by_user_id(session[:user])
   
    unless check_permission(roles, @controller.controller_name, 
                            @controller.action_name)
      access_denied and return false 
    end
  end
  
  def check_permission(roles,controller_name,action_name)
    roles.each { | rol |
      permission = Permission.find(:conditions => ['roleingroup_id = ? AND controller_id = ? AND action_id = ?', rol.id, controller_name, action_name])
      return true and break if permission
    }
  end
end

