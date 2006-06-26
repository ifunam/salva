module Rbac
  def rbac_required
    roles = get_roleingroup(session[:user])
    if roles == nil
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

  def get_roleingroup(user_id)
    rolesid = []
    roles = UserRoleingroup.find(:all, :conditions => [ 'user_id = ?', user_id])
    roles.each {  |rol| rolesid << rol.id }
    return rolesid if rolesid.length > 0
  end
  
  def check_permission(rol_id,controller_id,action_id)
    return true if Permission.find(:first, :conditions => ['roleingroup_id = ? AND controller_id = ? AND action_id = ?', rol_id, controller_id, action_id ])
  end
  
end

