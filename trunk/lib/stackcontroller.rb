module Stackcontroller
  def options_for_next_controller(model, controller, action, next_action='new')
    next_controller, attribute, id = options_from_params
    model_into_stack(controller, action, id, model, attribute)
    filter_into_stack(controller, action, params[:filt], attribute) if params[:filt]
    { :controller => next_controller, :action => next_action, :id => id }
  end

  def options_from_params
    stack_params = params[:stacklist].nil? ? params[:stack]: params[:stacklist]
    if stack_params =~ /:/
      params_array = stack_params.split(':')
      [ params_array[0], params_array[0]+'_id',   params[:edit][params_array[1].to_sym]  ||  params[:filt][params_array[1].to_sym] ]
    elsif stack_params =~ /\,/
      [ stack_params.split(',')[0], stack_params.split(',')[1] ]
    else
      [ stack_params, stack_params + '_id']
    end
  end

  def model_into_stack(controller, action, id, model=nil, attribute=nil)
    session[:stack] ||= StackOfController.new
    session[:stack].push(controller, action, id, model, attribute)
  end

  def filter_into_stack(controller, action, hash, attribute)
    session[:filter] ||= StackOfController.new
    session[:filter].push(controller, action, nil, hash, attribute)
  end

  def model_from_stack(item=:stack)
    if has_model_in_stack?(item)
      session[item].delete_after_controller(controller_name) if session[item].included_controller?(controller_name)
      if (session[item].controller == controller_name)
        model = session[item].model
        session[item].pop
        return model
      end
    end
    nil
  end

  def has_model_in_stack?(item=:stack)
    if session[item] and !session[item].empty? and session[item].model != nil
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
    if session[:stack] != nil and !session[:stack].empty?
      if session[:stack].included_controller?(controller_name)
        session[:stack].delete_after_controller(controller_name)
        session[:stack].pop
      end
      save_stack_attribute(id) if has_model_in_stack?
    end
    stack_controller
  end

  def stack_select(id)
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

  def stack_cancel
    return stack_controller
  end

  def stack_clear
        session[:stack].clear if session[:stack] != nil
  end

end
