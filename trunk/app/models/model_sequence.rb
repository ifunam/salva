class ModelSequence
  
  attr_accessor :sequence
  attr_accessor :current
  attr_accessor :is_filled  
  attr_accessor :return_controller
  attr_accessor :return_action
  attr_accessor :moduser_id
  attr_accessor :user_id
  attr_accessor :parent
  
  def initialize(array)
    component = []
    prev_child = nil
    first_child = nil
    array.each { |model| 
      if model.is_a? Array then
        composite = ModelSequence.new(model)
        composite.user_id =  @user_id if @user_id
        composite.moduser_id = @moduser_id if @moduser_id
        composite.return_action = 'list'
        @return_controller = composite.return_controller if first_child == nil
        composite.parent = prev_child if prev_child
        component << composite
      else
        child = model.new
        component << child
        prev_child = child
        first_child = child if first_child == nil
      end
    }
    @sequence = component
    @current = 0
    @is_filled = false
    @return_action = 'list'
    @return_controller = Inflector.underscore(first_child.class.name) unless first_child == nil
    @parent = nil
  end
  
  def fill(id)
    lider = @parent
    lider_id = Inflector.underscore(lider.class.name)+'_id' if lider != nil
    i = 0
    prev_child = nil
    @sequence.each { |child|
      if !is_sequence(child) then
        if lider == nil
          lider =  child.class.name.constantize.find(id) if id != nil
          lider_id = Inflector.underscore(lider.class.name)+'_id' if lider != nil
          @sequence[i] = lider
        elsif lider != nil then
          @sequence[i] = child.class.name.constantize.find(:first, :conditions => ["#{lider_id}  = ?", lider.id])
          prev_child = @sequence[i]
        end
      else
        child.parent = prev_child if prev_child
        child.fill(id)
      end
      i += 1
    }
  end


  def next_component
    if @current < @sequence.length 
      @current += 1
    else
      @is_filled = true
    end
  end
  
  def previous_component
    if @current > 0
      @current -= 1
    end	    
  end
  
  def get_model
    @sequence[@current] 
  end

  def get_model_name
    get_model.class.name
  end

  def is_last
    if @current == @sequence.length - 1
      @is_filled = true
       true 
    else
      false
    end
  end
  
  def is_sequence(child)
    return child.class == ModelSequence
  end

  def save
    lider = @parent != nil ? @parent: sequence[0]
    lider_id = Inflector.underscore(lider.class.name)+'_id'    
    @sequence.each { |model|            
      model.moduser_id = @moduser_id if model.has_attribute? 'moduser_id' 
      model.user_id = @user_id if model.has_attribute? 'user_id' 
      if model.class.name.to_s != self.class.name then
        # model['moduser_id'] = @moduser_id if model.has_attribute? 'moduser_id' 
        # model['user_id'] = @user_id if model.has_attribute? 'user_id' 
        if lider_id != nil then
          model[lider_id] = lider.id
        end
      end
      # if model.id != nil and model.id > 0
        model.save
      #     else
#        model.update_attributed(params)
#      end
    } 
  end    
  
  def is_composite
    is_sequence(get_model)
  end
  
  def flat_sequence
    flat = []
    @sequence.each { |child| 
      if is_sequence(child) then
        flat << child.flat_sequence 
      else
        flat << child
      end
    }
    flat.flatten
  end

  def delete
    array = flat_sequence.compact
    array.reverse_each { |child|
      child.destroy
    }   
    array
  end
  
  def set_current_by_element(element)
    @current = 0
    index = 0    
    @sequence.each { |child| 
      if is_sequence(child) then
        index += child.flat_sequence.length 
      else
        index += 1
      end
      break if (index > element)      
      @current += 1        
    }
  end

  def has_attribute?(s)
    true
  end

end

