module ComposedKeys
  def self.append_features(base)
    super
    base.extend(ClassMethods)
    base.extend(InstanceMethods)
  end
  
  module ClassMethods

    def set_primary_keys(*keys)
      keys = keys.first if keys.first.is_a?(Array)
      cattr_accessor :primary_keys 
      cattr_accessor :reserved_attributes
      self.primary_keys = keys.collect {|key| key.to_s}
      self.reserved_attributes = %w(created_on updated_on)

      class_eval <<-EOV
      include ComposedKeys::InstanceMethods
      EOV
    end
    
    def is_composed_keys?
      true
    end

  end
  
  module InstanceMethods

    def save
      attributes_with_values = set_attributes
      models = prepare_to_save_models(attributes_with_values)
      return false unless are_valid_models?(models)
      models.each { |model|
        sql = set_sql_to_save(model,attributes_with_values)
        connection.insert(sql,"#{self.class.name} Create", self.class.primary_key, self.id, self.class.sequence_name)
      }      
      return true
    end
    
    private
    def set_attributes
      attributes = Hash.new
      ((self.attributes.keys - self.reserved_attributes) - self.primary_keys).each { |key|
        attributes[key] = self.attributes_before_type_cast[key]
      }
      return attributes
    end
    
    def prepare_to_save_models(params)
      models = []
      i = 0
      while  i <= get_max_array_size_from_params(params)
        model = self.class.new
        self.primary_keys.each { |key| model.[]=(key, self.attributes[key]) }
        params.keys.each { |key| 
          if params[key].is_a? Array
            model.[]=(key, params[key][i])
          else
            model.[]=(key, params[key])
          end
        }
        models << model
        i = i + 1
      end
      return models
    end

    def get_max_array_size_from_params(params)
      array = params.collect { |key,value|  value.size if value.is_a?(Array) }
      array.sort.last ? array.sort.last - 1 : 0
    end 

    def are_valid_models?(models)
      models.each { |model| return false unless model.valid? }
      return true
    end

    def set_sql_to_save(model, attributes_with_values)
      keys = self.primary_keys + attributes_with_values.keys
      values = self.primary_keys.collect { |key| self.attributes[key] }
      attributes_with_values.keys.each {|key|  values << model.send(key) }
      "INSERT INTO #{self.class.table_name} (#{keys.join(', ')}) VALUES (#{values.join(',')} )"
    end

  end

end

require 'active_record'
ActiveRecord::Base.class_eval do
  include ComposedKeys
end

