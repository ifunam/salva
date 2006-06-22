module Rbac
  def rbac_required
    authorized = false
    roles = UserRoleingroups.find(:all, :conditions => [ "'user_id' = ? ", session[:user]))
    roles.each { | rol |
      permission = Permission.find(:first, :conditions => [ "'roleingroup_id = ? AND controller_id = ? AND action_id = ? ", rol.id, @controller.controller_class_name, @controller.action_name])
      authorized = true and last if permission
    }
    access_denied and return false if authorized == false
  end
end

  
