class StackOfController

  def initialize()
    @stack = [ ] 
  end
  
  def push(controller, action)
    @stack << [ controller, action ]
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

  def get_model
    if has_items? 
      model_name = Inflector.constantize(Inflector.camelize(@stack.last[0]))
    end
  end

  def get_controller
    has_items? ? @stack.last[0]: nil
  end

  def get_action
    has_items? ? @stack.last[1]: nil
  end

  def get_id
    has_items? ? @stack.last[2]: nil
  end

  private
  def last
    @stack.last
  end

end

