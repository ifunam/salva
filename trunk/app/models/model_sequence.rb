class ModelSequence

  attr_accessor :sequence
  attr_accessor :current
  attr_accessor :is_filled
  attr_accessor :lider
  attr_accessor :lider_id
  attr_accessor :return_controller
  attr_accessor :return_action
  
  def initialize(array)
    @sequence = array 
    @current = 0;
    @is_filled = false
    @lider = @sequence[0].class.name.downcase
    @lider_id = @lider+'_id'
    @return_controller = @lider
    @return_action = 'list'
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
    first = @sequence[0]
    first.save
    last = @sequence.length - 1
    for i in (1..last)
      model = sequence[i]   
      model[lider_id] = first.id
      model['moduser_id'] = first.moduser_id
      model.save
    end    
  end

end

