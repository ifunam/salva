class ModelComposedKeys 
  attr_accessor :composed_keys
  attr_accessor :model
  attr_accessor :moduser_id
  attr_accessor :user_id
  attr_accessor :models
  
  def initialize(model, keys)
    @model = model
    @composed_keys = keys
  end
  
  def prepare(params)
    attributes = params.keys - @composed_keys
    i = 0
    @models = []
    while  i <= get_max_array_size(params, attributes)
      model = @model.new
      @composed_keys.each { |attribute| model.[]=(attribute, params[attribute.to_sym]) }
      params.each { |key, value| 
        next if @composed_keys.include?(key)
        if value.is_a?(Array) then
          model.[]=(key, value[i]) 
        else
          model.[]=(key, value) 
        end
      }
      @models << model
      i = i + 1
    end
  end
  
  def get_max_array_size(params, attributes)
    array = []
    params.each { |key,value| array << value.size if value.is_a?(Array) and attributes.include?(key) }
    array.sort.last ? array.sort.last - 1 : 0
  end  
  
  def is_valid?
    @models.each { |model| return false unless model.valid? }
    return true
  end
  
  def save
    @models.each { |model|
      model['moduser_id'] = @moduser_id if model.has_attribute? 'moduser_id' 
      model.save
    }
  end
  
  def list
    collection = @model.find(:all, :select => @composed_keys.join(','), :group => @composed_keys.join(','))
    mylist = []
    collection.each { |row|
      conditions = set_conditions(row, @composed_keys)
      attributes = %w(user_id roleingroup_id) - @composed_keys
      grouped_collection = @model.find(:all, :select => attributes.join(','), :conditions => conditions)
      attributes.each { |attribute|
        array = []
        grouped_collection.each { |row2| array << row2.send(attribute) }
        row.[]=(attribute, array) 
        mylist << row
      }
    }
    mylist
  end
  
  def set_conditions(row, keys)
    conditions = [ keys.collect { |key|  key + ' = ?' }.join(' AND ') ]
    keys.each { |key| conditions << row.send(key) }
    return conditions
  end
  
end
