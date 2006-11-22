class StackOfController
  
  def initialize()
    @stack = [ ] 
  end
  
  def push(model, action, handler, controller=nil)
    @stack << [ model, action, handler, controller] 
  end
  
  def pop
    @stack.pop
  end
  
  def size
    @stack.length
  end
  
  def has_items?
    if  @stack.length > 0 or @stack.empty? == false
      true
    else
      false
    end
  end
  
  def top?
    @stack.length==1
  end
  
  def empty?
    @stack.empty?
  end
  
  def get_model
    if has_items? 
      get_updated_model
    end
  end
  
  def get_controller
    has_items? ? set_controller_name : nil
  end

  def get_action
    has_items? ? @stack.last[1]: nil
  end

  def set_handler_id(id)
    @stack.last[4] = id if has_items? 
  end

  private
  def last
    @stack.last
  end
  
  def get_updated_model
    model = @stack.last.first
    model.[]=(get_handler, get_handler_id)
    return  model
  end
  
  def get_handler_id 
    has_items? ? @stack.last[4] : nil
  end
  
  def get_handler
    has_items? ? @stack.last[2] : nil
  end

  def set_controller_name
    if @stack.last[3] == nil 
      class_name = @stack.last.first.class.name
      class_name != 'ModelSequence' ? Inflector.singularize(Inflector.tableize(class_name)) : 'wizard'
    else
      @stack.last[3]
    end
  end
end

