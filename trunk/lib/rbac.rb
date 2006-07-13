module Rbac
  def rbac_required
    roles = get_roleingroups(session[:user])

    if roles.length <= 0
      flash[:warning] = 'Por favor defina un rol para el usuario en sesión...'
    else
      controller = Controller.find_by_name(controller_name) 
      action = Action.find_by_name(action_name) 
      if controller and action
        authorized = false
        roles.each { | role_id |
          if check_permission(role_id, controller.id, action.id) 
            authorized = true 
            break
          end
        }
        if authorized == false
          flash[:warning] = "No tiene permisos para usar este controlador '#{controller_name} => #{action_name}'..."
        end
      else 
        flash[:warning] = "El controlador '#{controller_name}' o la acción '#{action_name}' aún no estan registrados.."
      end
    end
    
    if flash[:warning] 
      redirect_to :controller =>"/rbac", :action => 'index'
      return false
    end
  end
  
  def get_roleingroups(user_id)
    rolesid = []
    roles = UserRoleingroup.find(:all, :conditions => [ 'user_id = ?', user_id])
    roles.each {  |rol| rolesid << rol.id }
    return rolesid 
  end

  def get_groups(user_id)
    groupsid = []
    roles = UserRoleingroup.find(:all, :conditions => [ 'user_id = ?', user_id])
    roles.each {  |rol| 
      groupsid << rol.group_id if is_a_salva_member?(user_id,rol.group_id) 
    }
    return groupsid
  end

  def is_a_salva_member?(user_id, group_id)
    roleingroup = UserRoleingroup.find(:first, 
                                       :conditions => [ 'user_id = ? AND group_id', 
                                                        user_id, group_id])
    if roleingroup.role.name == 'Salva' and roleingroup.role.has_group_right == false  
      return true 
    end
  end
  
  def has_rights_overuser?(user_id, thisuser_id)
    groups = get_groups(thisuser_id)    
    groups.each { | group_id |
      return true if has_group_rights?(user_id, group_id)
    }
  end
  
  def has_group_rights?(user_id, group_id)
    roleingroup = UserRoleingroup.find(:first, 
                                       :conditions => [ 'user_id = ? AND group_id', 
                                                        user_id, group_id])
    return true  if roleingroup.role.has_group_right
    return false
  end
  
  def get_roleingroup_id(id)
    rol = UserRoleingroup.find(:first, :conditions => [ 'id = ?', id])
    return rol.roleingroup_id
  end

  def is_admin?(user_id)
    user_roleingroups = get_roleingroups(user_id)
    user_roleingroups.each { |user_roleingroup_id|
      roleingroup_id = get_roleingroup_id(user_roleingroup_id)
      roleingroup = Roleingroup.find(:first, roleingroup_id)
#      if roleingroup.group.name == 'ADMIN' and \
#        roleingroup.role.name == 'Administrador' and \
#        roleingroup.role.has_group_right 
      if roleingroup.group_id == 1 and  roleingroup.role_id == 1
        logger.info("IS_ADMIN"+roleingroup_id.to_s+user_id.to_s + roleingroup.group_id.to_s + roleingroup.role_id.to_s)
        return true
      end
    }
    return false
  end
  
  def check_permission(rol_id,controller_id,action_id)
    return false unless Permission.find(:first, :conditions => ['roleingroup_id = ? AND controller_id = ? AND action_id = ?', rol_id, controller_id, action_id ]) 
    return true
  end
  
end

