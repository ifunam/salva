module Stackcontroller
  def options_for_next_controller(model, controller, action, form_params, stack_params)
    # 'controller' will be used as return_controller
    # 'next_controller' will be used as previus_controller
    next_controller, attribute, id = set_options(stack_params, form_params)
    model_into_stack(controller, action, id, model, attribute)
    { :controller => next_controller, :action => 'new', :id => id }
  end
  
  def model_into_stack(controller, action, id, model=nil, attribute=nil)
    session[:stack] ||= StackOfController.new
    session[:stack].push(controller, action, id, model, attribute)
  end 

  def set_options(stack_params, form_params)
    if stack_params =~ /:/
      [ stack_params.split(':')[0], stack_params.split(':')[1], 
        form_params[stack_params.split(':')[1].to_sym] ]
    elsif stack_params =~ /\,/
      [ stack_params.split(',')[0], stack_params.split(',')[1] ]
    else
      [ stack_params, stack_params + '_id']
    end
  end
  
  def model_from_stack
    if has_model_in_stack?      
      session[:stack].delete_after_controller(controller_name) if session[:stack].included_controller?(controller_name)
      if (session[:stack].controller == controller_name)
        model = session[:stack].model
        session[:stack].pop
        return model
      end
    end
    nil
  end
  
  def has_model_in_stack?
    if session[:stack] and !session[:stack].empty? and session[:stack].model != nil
      return true
    end
    return false
  end

  def save_stack_attribute(value)
    session[:stack].set_attribute(value) 
  end

  def options_for_return_controller
    options = {:controller => controller_name, :action => 'list'}
    if has_model_in_stack?
      if session[:stack].previus_controller == controller_name
        options = { :controller => session[:stack].return_controller, 
          :action => session[:stack].action }
        options[:id] = session[:stack].value if session[:stack].attribute == 'id'
      end
    end
    options
  end

  def stack_return(id) 
    if session[:stack].included_controller?(controller_name)
      session[:stack].delete_after_controller(controller_name)             
      session[:stack].pop
    end
    save_stack_attribute(id) if has_model_in_stack?
    stack_controller
  end
    
  def stack_controller
    hash = {:action => 'list' } 
    if session[:stack] != nil and !session[:stack].empty?
      hash = { :controller => session[:stack].controller, 
        :action => session[:stack].action, 
        :id => session[:stack].id }
    end
    hash
  end

  def stack_back
    if session[:stack] != nil and !session[:stack].empty?
      session[:stack].pop
    end
    return stack_controller
  end

  def stack_clear
        session[:stack].clear if session[:stack] != nil
  end
  
end
