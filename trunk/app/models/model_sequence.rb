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
    array.each { |model| 
      if model.is_a? Array then
        composite = ModelSequence.new(model)
        composite.parent = prev_child if prev_child
        component << composite
      else
        child = model.new
        component << child
        prev_child = child
      end
    }
    @sequence = component
    @current = 0
    @is_filled = false
    @return_action = 'list'
    @return_controller = Inflector.underscore(array[0].name)
    @parent = nil
  end
  
  def next_model
    if @current < @sequence.length 
      @current += 1
      @current += 1 if @sequence[@current+1].class.name == self.class.name
    else
      @is_filled = true
    end
  end
  
  def previous_model
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
  
  def save
    lider = @parent ? @parent: sequence[0]
    lider_id = Inflector.underscore(lider.class.name)+'_id'    
    @sequence.each { |model|      
      if model.class.name.to_s != self.class.name then
        model['moduser_id'] = @moduser_id if model.has_attribute? 'moduser_id' 
        model['user_id'] = @user_id
        if lider_id != nil then
          model[lider_id] = lider.id
        end
      end
      model.save
    } 
  end    
  
  def is_composite
    get_model.class.name == self.class.name ? true : false
  end
  
  def get_children
    children = [ @parent ]
    @sequence.each { |model| 
      model.class.name.to_s != self.class.name ? children << model : break
    }
    children.compact
  end

  def flat_sequence
    flat = []
    @sequence.each { |model| 
      if model.class.name.to_s != self.class.name then
        flat << model 
      else
        flat << model.flat_sequence
      end
    }
    flat.flatten
  end

end

