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
    @parent = array.first
    array.each { |model| 
      if model.is_a? Array then
        composite = ModelSequence.new(model)
        component << composite
      else
        component << model.new
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
    lead_id = @lider_id
    prev_model = nil
    @sequence.each { |model|      
      model['moduser_id'] = @moduser_id 
      model['user_id'] = @user_id
      if @lider_id != nil then
        model[@lider_id] = @lider.id
      elsif prev_model != nil then
        model[Inflector.underscore(prev_model.class.name)+'_id'] = prev_model.id
      end
      model.save
      prev_model = model
    } 
  end    
   
  def set_lider(id, name)
    @lider_name = name+'_id'
    @lider_id = id
    @return_controller = name
    @return_action = 'list'
  end
  
  def is_composite
    get_model.class.name == self.class.name ? true : false
  end

  def get_children
    children = []
    @sequence.each { |model| 
      model.class.name.to_s != self.class.name ? children << model : break
    }
    children.compact
  end
end

