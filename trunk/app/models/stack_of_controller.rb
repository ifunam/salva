class StackOfController
  
  def initialize()
    @stack = [ ] 
  end
  
  def push(model, action, handler, id=nil)
    @stack << [ model, action, handler, id]
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
      @stack.last[0] 
    end
  end

  def get_controller
    controller_name = (@stack.last[0].class.name != 'ModelSequence') ? Inflector.singularize(Inflector.tableize(@stack.last[0].class.name)) : 'wizard'
    has_items? ? controller_name: nil
  end

  def get_action
    has_items? ? @stack.last[1]: nil
  end

  def set_handler_id(id)
    @stack[@stack.length - 1][3] = id if has_items? 
  end
  
  def get_handler_id 
    has_items? ? @stack[@stack.length - 1][3] : nil
  end

  def get_handler
    has_items? ? @stack[@stack.length - 1][2] : nil
  end
  
  private
  def last
    @stack.last
  end
end

