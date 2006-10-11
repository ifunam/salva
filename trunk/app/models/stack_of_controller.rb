class StackOfController

  def initialize()
    @stack = [ ] 
  end
  
  def push(model, action)
    @stack << [ model, action ]
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
      @stack.last[0] #model_name = Inflector.constantize(Inflector.camelize(@stack.last[0]))
    end
  end

  def get_controller
    has_items? ? Inflector.singularize(Inflector.tableize(@stack.last[0].class.name)) : nil
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

