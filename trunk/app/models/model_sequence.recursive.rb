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
    @sequence = array.collect{ |model| 
      if model.is_a? Array then
        sequence = ModelSequence.new(model)
        sequence.parent = self
      else
        model.new 
      }
    @current = 0;
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
    
   
  def set_lider(model_instance)     
    @lider = model_instance
    name = Inflector.underscore(@lider.class.name)
    @lider_id = name+'_id'
    @return_controller = name
    @return_action = 'list'
  end
  
end

