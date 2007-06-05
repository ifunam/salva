class StackOfController
 
  def initialize()
    @stack = [ ] 
  end
  
  def push(model, action, attribute, controller=nil, prev_controller=nil)
    return false if Inflector.constantize(model.class.name) != ModelSequence and !model.has_attribute?(attribute)  
    return_controller = controller || set_controller_name(model)
    previus_controller = prev_controller || Inflector.tableize(attribute.sub(/_id$/,'')).singularize
    if include_controller?(return_controller)
      #Avoiding controller collissions (Perhaps it is a bug, but it helps to avoid infinite loops..)
      @stack[index_by_controller(controller)] = [ model, return_controller, action, attribute, nil, previus_controller ]
    else
      @stack << [ model, return_controller, action, attribute, nil, previus_controller] 
    end
  end
  
  def pop
    @stack.pop
  end

  def clear
    @stack = [ ]
  end

  def size
    @stack.length
  end

  def empty?
    @stack.empty?
  end
  
  # These methods will use the last item from stack
  def pop_model
    unless @stack.empty?
      model = updated_model
      @stack.pop
      model
    end
  end

  def model
    updated_model unless @stack.empty?
  end


  def return_controller
    @stack.last[1] unless @stack.empty?
  end
  
  def action
    @stack.last[2] unless @stack.empty?
  end

  def attribute
    @stack.last[3] unless @stack.empty?
  end

  def value
    unless @stack.empty?
      (@stack.last[4] == nil) ? value_from_current_model : @stack.last[4] 
    end
  end

  # This method should be used after save a record when are using the stack to
  # return to some controller.
  def set_attribute(value)
    @stack.last[4] = value unless @stack.empty?
  end

  # Methods to stack handling using an specific controller name 
  def delete_after_controller(controller_name)
    index = index_by_controller(controller_name)
    @stack = (0 .. index).collect { |i| @stack[i] } # Check delete_at method from array class
  end

  def include_controller?(controller_name)
    index_by_controller(controller_name) == nil ? false : true
  end

  def previus_controller
    @stack.last[5] unless @stack.empty?
  end
  
  private
  def set_controller_name(model)
    model.class == ModelSequence ? 'wizard' : Inflector.underscore(model.class.name)
  end
  
  def updated_model
    model = @stack.last.first
    if Inflector.constantize(model.class.name) == ModelSequence
      model_sequence = model.get_model
      model_sequence.[]= (attribute_name, attribute_value)
    else      
      model.[]= (attribute_name, attribute_value)
    end
    return model
  end
  
  def attribute_name
    @stack.last[3] unless @stack.empty?
  end
  
  def attribute_value
    @stack.last[4] unless @stack.empty?
  end
  
  # This method will be used when we don't upgrade the attribute value in the
  # current model in stack.
  def value_from_current_model
    model = @stack.first[0]
    if model.class == ModelSequence
      model_sequence = model.get_model
      model_sequence.send(attribute_name) if model_sequence.attribute_present?(attribute_name)
    else
      model.send(attribute_name) if model.attribute_present?(attribute_name)
    end
  end

  def index_by_controller(controller_name)
    i = 0
    @stack.each do |item|
      return i if item[1] == controller_name
      i = i + 1
    end
    return nil
  end
end

