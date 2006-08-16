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
    while  i <= max_array_size_from_params(params, attributes)
      model = @model.new
      self.set_composed_keys(model,@composed_keys, params)
      self.set_keys(model,@composed_keys, params, i)
      @models << model
      i = i + 1
    end
  end
  
  def max_array_size_from_params(params, attributes)
    array = []
    params.each { |key,value| 
      array << value.size if value.is_a?(Array) and attributes.include?(key) 
    }
    array.sort.last ? array.sort.last - 1 : 0
  end    

  def set_composed_keys(model,keys,params)
    keys.each { |attribute| 
      model.[]=(attribute, params[attribute.to_sym]) 
    }
  end  
  
  def set_keys(model,keys,params,i)
    params.each { |key, value| 
      next if keys.include?(key)
      if value.is_a?(Array) then
        model.[]=(key, value[i]) 
      else
        model.[]=(key, value) 
      end
    } 
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
    collection = @model.find(:all, :select => @composed_keys.join(','), 
                             :group => @composed_keys.join(','))
    mylist = []
    collection.each { |row|
      conditions = set_conditions(row, @composed_keys)
      attributes = %w(user_id roleingroup_id) - @composed_keys
      grouped_collection = @model.find(:all, :select => attributes.join(','), :conditions => conditions)
      attributes.each { |attribute|
        array = []
        grouped_collection.each { |row2| array << row2.send(attribute) }
        row.[]=(attribute, array) 
        row.id = @composed_keys.collect { |key| row.send(key) }.join(':')
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

  def set_conditions2(values, keys)
    conditions = [ keys.collect { |key|  key + ' = ?' }.join(' AND ') ]
    values.each { |value| conditions << value }
    return conditions
  end

  def find(composed_id)
    ids = composed_id.split(':')
    i = 0
    conditions = set_conditions2(ids, @composed_keys)
    row = @model.find(:first, :conditions => conditions)
    attributes = %w(roleingroup_id user_id) - @composed_keys
    grouped_collection = @model.find(:all, :select => attributes.join(','), 
                                     :conditions => conditions)
    attributes.each { |attribute|
      array = []
      grouped_collection.each { |row2| array << row2.send(attribute) }
      row.[]=(attribute, array) 
      row.id = @composed_keys.collect { |key| row.send(key) }.join(':')
    }
    row
  end

  def update(params)
    composed_id = []
    @composed_keys.collect { |key| composed_id << params[key] }
    mymodel = self.find(composed_id.join(':'))
    new_items= Hash.new
    delete_items= Hash.new
    (mymodel.attribute_names & params.keys).each { |key| 
      next if @composed_keys.include?(key)
      if params[key].is_a?(Array) and mymodel.attributes_before_type_cast[key].is_a?(Array) 
        array = []
        params[key].each { |item| array << item.to_i }
        new_items[key] = array - mymodel.attributes_before_type_cast[key]
        delete_items[key] = mymodel.attributes_before_type_cast[key] - array
      end
    }
    i = 0
    myparams = Hash.new
    @composed_keys.each { |key| 
      myparams[key.to_sym] = params[key]
    }
    new_items.each {  |key, value|
      myparams[key.to_sym] = value
    }
    self.prepare(myparams) 
    if self.is_valid?
      self.save
    end
    #  #      #    @Models << @model.new()
    #  #      #    @models << @model.find() @model.delete
  end

  def destroy(delete_items)
    
  end
 
  #  attributes = params.keys - @composed_keys
  #  @models = []
  #  i = 0
  #  while  i <= max_array_size_from_params(params, attributes)
  #    self.set_composed_keys(model,@composed_keys, params)
  #    self.set_keys(model,@composed_keys, params, i)
  #    @models << model
  #    i = i + 1
  #  end
  #end

end
