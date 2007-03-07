module Stackcontroller
  def set_model_into_stack(model,action,handler,myparams,controller)
    options = set_options(handler,myparams)
    save_model_into_stack(model,action,options[:handler_id],controller) 
    redirect_to_controller(options[:handler],'new', options[:id]) 
  end
  
  def set_options(handler,myparams)
    if handler =~ /:/
      { :handler => handler.split(':')[0], :handler_id => handler.split(':')[0] + '_id', :id => myparams[handler.split(':')[1].to_sym] }
    elsif handler =~ /\,/
      { :handler => handler.split(',')[0], :handler_id => handler.split(',')[1] }
    else
      { :handler => handler, :handler_id => handler + '_id'}
    end
  end
  
  def save_model_into_stack(object,action,handler,controller=nil)
    session[:stack] ||= StackOfController.new
    if controller == Inflector.pluralize(Inflector.tableize(object))
      session[:stack].push(object,action,handler)
    else
      session[:stack].push(object,action,handler,controller)
    end
  end

  def get_model_from_stack
    unless session[:stack].empty?
     model = session[:stack].get_model
      logger.info "STACK " +model.attribute_names.flatten.to_s
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
      if  session[:stack].get_handler.sub(/_id$/,'') == controller_name
        [ session[:stack].get_controller, session[:stack].get_action ] 
      else
        session[:stack].set_empty
        [ controller_name, 'list'] 
      end
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
