module Stackcontroller
  def set_model_into_stack(model,controller,action='new')
    save_model_into_stack(@edit,action) 
    redirect_to_controller(@params[:stack]) 
  end

  def save_model_into_stack(object,action)
    session[:stack] ||= StackOfController.new
    session[:stack].push(object,action)
  end

  def get_model_from_stack
    unless session[:stack].empty?
      model = session[:stack].get_model         
      session[:stack].pop 
      return model
    end
  end
  
  def has_model_in_stack?
    if session[:stack]
      return true unless session[:stack].empty? 
    end
    return false
  end
  
  def is_this_model_in_stack?
    if has_model_in_stack? 
      return true if session[:stack].get_controller == controller_name
    end
    return false
  end

  def get_controller_options_from_stack
    if has_model_in_stack? 
      [ session[:stack].get_controller, session[:stack].get_action ] 
    else
      [ controller_name, 'list'] 
    end
  end
  
  def redirect_to_controller(controller, action='new')
    redirect_to :controller => controller, :action => action
    return true
  end
end
