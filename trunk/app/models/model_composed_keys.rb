class ModelComposedKeys < ActiveRecord::Base
  include ComposedKeys
  attr_accessor :composed_keys
  attr_accessor :model
  attr_accessor :moduser_id
  attr_accessor :user_id
  
  def save 
    uncomposed_attributes = set_uncomposed_attributes
    models = fill_models(uncomposed_attributes)
    return false unless are_valid_models?(models)
    models.each { |model|
      sql = set_sql_to_save(model, uncomposed_attributes)
      connection.insert(sql,"#{self.class.name} Create", self.class.primary_key, self.id, self.class.sequence_name)
    }      
    return true
  end
  
  private
  def set_uncomposed_attributes
    attributes = Hash.new
    ((self.attributes.keys - self.reserved_attributes) - self.primary_keys).each { |key|
      attributes[key] = self.attributes_before_type_cast[key]
    }
    return attributes
  end
  
  def fill_models(uncomposed_attributes)
    models = []
    i = 0
    while  i <= get_max_array_size(uncomposed_attributes)
      models << fill_model(uncomposed_attributes, i)
      i = i + 1
    end
    return models
  end

  def fill_model(uncomposed_attributes, i)
    model = self.class.new
    self.primary_keys.each { |key| model.[]=(key, self.attributes[key]) }
    uncomposed_attributes.keys.each { |key| 
      if uncomposed_attributes[key].is_a? Array
        model.[]=(key, uncomposed_attributes[key][i])
      else
        model.[]=(key, uncomposed_attributes[key])
      end
    }
    return model
  end
  
  def get_max_array_size(uncomposed_attributes)
    array = uncomposed_attributes.collect { |key,value|  value.size if value.is_a?(Array) }
    array.sort.last ? array.sort.last - 1 : 0
  end 
  
  def are_valid_models?(models)
    models.each { |model| return false unless model.valid? }
    return true
  end

  def set_sql_to_save(model, uncomposed_attributes)
    keys = self.primary_keys + uncomposed_attributes.keys #+ self.reserved_attributes
    values = self.primary_keys.collect { |key| self.attributes[key] }
    uncomposed_attributes.keys.each {|key|  values << model.send(key) }
    #self.reserved_attributes.each { |key| values << self.attributes[key] }
    "INSERT INTO #{self.class.table_name} (#{keys.join(', ')}) VALUES (#{values.join(',')} )"
  end
end
