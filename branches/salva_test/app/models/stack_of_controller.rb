class StackOfController

  def initialize()
    @stack = [ ]
  end

  def push(controller, action, id=nil, model=nil, attribute=nil)
    index = index_by_controller(controller)
      #Avoiding controller collissions (Perhaps it is a bug, but it helps to avoid infinite loops..)

    attribute = nil if model!=nil and !model.is_a?Hash and attribute!=nil and !model.has_attribute?(attribute)
    unless index == nil
      @stack[index] = [ controller, action, id, model, attribute ]
    else
      @stack << [ controller, action, id, model, attribute ]
    end
  end

  def pop
    @stack.pop
  end

  def clear
    @stack.clear
  end

  def size
    @stack.length
  end

  def empty?
    @stack.empty?
  end

  def controller
    @stack.last[0] unless @stack.empty?
  end

  def action
    @stack.last[1] unless @stack.empty?
  end

  def id
    @stack.last[2] unless @stack.empty?
  end

  def model
    m = @stack.last[3] unless @stack.empty?
    if Inflector.constantize(m.class.name) == ModelSequence
      return m.get_model
    end
    return m
  end

  def attribute
    @stack.last[4] unless @stack.empty?
  end

  # This method should be used after save a record when are using the stack to
  # return to some controller.
  def set_attribute(value)
    unless @stack.empty?
      m = model
      t = attribute
      unless m == nil or t == nil
        if  (m.class.superclass  ==   ActiveRecord::Base  ||  ModelComposedKeys)  ||  Inflector.constantize(m.class.name) == ModelSequence
          m = model.get_model if Inflector.constantize(m.class.name) == ModelSequence
          m.[]=(t, value)
        elsif m.class == Hash
          m[t] = value
        end
      end
    end
  end

  # Methods to stack handling using an specific controller name
  def delete_after_controller(controller_name)
    index = index_by_controller(controller_name)
    @stack.slice!(index+1 .. -1) if index != nil
#    @stack = (0 .. index).collect { |i| @stack[i] } # Check delete_at method from array class
  end

  def included_controller?(controller_name)
    index_by_controller(controller_name) == nil ? false : true
  end


  private

  def index_by_controller(controller)
    i = 0
    @stack.each do |item|
      return i if item[0] == controller
      i = i + 1
    end
    return nil
  end

end

