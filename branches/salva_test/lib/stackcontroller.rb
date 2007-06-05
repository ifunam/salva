module Stackcontroller
  def options_for_next_controller(model, controller, action, form_params, stack_params)
    # 'controller' will be used as return_controller
    # 'next_controller' will be used as previus_controller
    next_controller, attribute, id = set_options(stack_params, form_params)
    model_into_stack(model, action, attribute, controller, next_controller)
    { :controller => next_controller, :action => 'new', :id => id }
  end
  
  def model_into_stack(model, action, attribute, controller=nil, next_controller=nil)
    # 'controller' will be used as return_controller
    # 'next_controller' will be used as previus_controller
    session[:stack] ||= StackOfController.new
    session[:stack].push(model, action, attribute, controller, next_controller)
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
      if session[:stack].include_controller?(controller_name)
        session[:stack].delete_after_controller(controller_name)
        return session[:stack].pop_model
      end
    end
  end
  
  def has_model_in_stack?
    if session[:stack]
      return true unless session[:stack].empty? 
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
  
  def stack_back
    hash = {:action => 'list' } 
    if has_model_in_stack?
      session[:stack].pop
      if has_model_in_stack?
        hash = { :controller => session[:stack].return_controller, 
          :action => session[:stack].action, 
          :id => session[:stack].value }
      end
    end
    hash
  end

end
