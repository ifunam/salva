class Stack

  def initialize(node=nil)
    @stack = node ? [ node ] : []
  end
  
  def push(item)
    @stack << item
  end

  def pop
    @stack.pop
  end

  def size
    @stack.length
  end

  def has_items?
    if self.size > 0 or @stack.empty? == false
      true
    else
      false
    end
  end

end

