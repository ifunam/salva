module Stackcontroller
  def set_model_into_stack(model,action,handler,myparams)
    options = set_options(handler,myparams)
    save_model_into_stack(model,action,options[:handler]+'_id') 
    redirect_to_controller(options[:handler],'new', options[:id]) 
  end
  
  def set_options(handler,myparams)
    options = { :id => nil}
    if handler =~ /:/
      attribute = handler.split(':')[1]
      options[:handler] = handler.split(':')[0]
      options[:id] = myparams[attribute.to_sym]
    else
      options[:handler] = handler
    end
    options
  end

  def save_model_into_stack(object,action,handler)
    session[:stack] ||= StackOfController.new
    session[:stack].push(object,action,handler)
  end

  def get_model_from_stack
    unless session[:stack].empty?
      model = session[:stack].get_model         
      pop_model_from_stack
      return model
    end
  end

  def pop_model_from_stack
    session[:stack].pop unless session[:stack].empty?
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
  
  def redirect_to_controller(controller, action='new', id=nil)
    redirect_to :controller => controller, :action => action, :id => id
    return true
  end

  def set_stack_handler_id(id)
    session[:stack].set_handler_id(id)
  end
end
