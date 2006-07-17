module Rbac
  def rbac_required
    uroles = get_roleingroups(session[:user])
    
    if uroles.length <= 0
      flash[:warning] = 'Por favor defina un rol para el usuario en sesión...'
    else
      controller = Controller.find_by_name(controller_name) 
      action = Action.find_by_name(action_name) 
      if controller and action 
        unless is_authorized?(uroles, controller.id, action.id)
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

  def is_admin?(user_id)
    roleingroups = get_roleingroups(user_id)
    roleingroups.each { |roleingroup_id|
      roleingroup = Roleingroup.find(:first, :conditions => [ 'id = ?', roleingroup_id])
      if roleingroup.group.name == 'ADMIN' and \
        roleingroup.role.name == 'Administrador' and \
        roleingroup.role.has_group_right 
        return true
      end
    }
    return false
  end
  
  def get_roleingroups(user_id)
    rolesid = []
    roles = UserRoleingroup.find(:all, :conditions => [ 'user_id = ?', user_id])
    roles.each {  |rol| rolesid << rol.roleingroup_id }
    return rolesid 
  end
  
  def has_rights_overuser?(user_id,thisuser_id)
    return true if user_id.to_i == thisuser_id.to_i
    
    groups = groups_with_basic_role(thisuser_id)    
    groups.each { | group_id |
      return true if has_group_rights?(user_id, group_id)
    }
    return false
  end
  
  def groups_with_basic_role(user_id)
    groupsid = []
    roleingroups = get_roleingroups(user_id)
    roleingroups.each { |roleingroup_id|
      roleingroup = Roleingroup.find(:first, :conditions => [ 'id = ?', roleingroup_id])
      if roleingroup.role.name == 'Salva' and roleingroup.role.has_group_right == false
        groupsid << roleingroup.group_id 
      end
    }
    return groupsid
  end
  
  def has_group_rights?(user_id, group_id)
    uroleingroups = get_roleingroups(user_id)
    uroleingroups.each { | roleingroup_id |
      roleingroup = Roleingroup.find(:first, 
                                     :conditions => [ 'id = ?', roleingroup_id])
      return true if roleingroup.group_id == group_id and roleingroup.role.has_group_right
    }
    return false
  end

  def is_authorized?(uroles, controller_id, action_id)
    uroles.each { | roleingroup_id |
      return true if check_permission(roleingroup_id, controller_id, action_id)
    }
    return false
  end

  def check_permission(rol_id,controller_id,action_id)
    return false unless Permission.find(:first, :conditions => ['roleingroup_id = ? AND controller_id = ? AND action_id = ?', rol_id, controller_id, action_id ]) 
    return true
  end
end

