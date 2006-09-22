require 'sql'
class ModelComposedKeys < ActiveRecord::Base
  
  # Class Methods
  class << self
    include Sql

    def set_primary_keys(*keys)
      cattr_accessor :primary_keys, :reserved_attributes 
      self.primary_keys = keys.collect {|key| key.to_s}
      self.reserved_attributes = %w(created_on updated_on)
    end

    def find(*args)
      options = extract_options_from_args!(args)
      case args.first      
      when :first         then find_first_composed_keys(options)
      when :first_nogroup then first_nogroup_composed_keys(options)
      when :all           then find_every_composed_keys(options)
      when :all_nogroup   then every_nogroup_composed_keys(options)
      else                find_composed_keys(args.first)
      end
    end

    private
    def find_composed_keys(ids)
      set_ids(ids) 
      conditions = set_conditions(self.primary_keys,ids.split(':'))
      record = find_initial({:conditions => conditions})
      attributes = (record.attribute_names - self.reserved_attributes) - self.primary_keys
      grouped_records = find_every({:select => attributes.join(','), :conditions => conditions})
      record = set_arrays_in_record(record, grouped_records, attributes)
      record.id = ids
      record
    end

    def find_every_composed_keys(options)
      grouped_records = find_every({:select => self.primary_keys.join(','), :group => self.primary_keys.join(',')})
      grouped_records.collect { |grouped_record| find_composed_keys(get_ids_from_record(grouped_record)) }
    end

    def find_first_composed_keys(options)
      record = find_initial({:conditions =>  options[:conditions]})
      if record != nil
        grouped_records = find_every({:conditions => options[:conditions]})
        attributes = (record.attribute_names - self.reserved_attributes) - self.primary_keys
        record = set_arrays_in_record(record, grouped_records, attributes)
        record
      end
    end

    def first_nogroup_composed_keys(options)
      find_initial({:conditions =>  options[:conditions]})
    end

    def every_nogroup_composed_keys(options)
      find_every({:conditions => options[:conditions]})
    end
    
    def set_ids(ids)
      cattr_accessor :ids
      self.ids = ids
    end

    def set_arrays_in_record (record, records, attributes)
      attributes.each { |attribute|
        array = records.collect { |myrecord| myrecord.send(attribute) }
        record.[]=(attribute.to_sym, array)
      }
      record
    end

    def get_ids_from_record(record)
      self.primary_keys.collect { |key| record.send(key) }.join(':')
    end
  end

  # Instance Methods
  include Sql

  def destroy
    conditions = set_conditions(self.primary_keys,self.ids.split(':')) 
    self.class.find(:all_nogroup, :conditions => conditions).each { |object|
      self.class.delete(object.attributes['id'])
    }
  end

  def save 
    (self.public_methods.include? 'ids') ? my_update : my_save
  end
  
  private

  def my_save
    attributes = get_uncomposed_attributes
    models = fill_models(attributes)
    return false unless are_valid_models?(models)
    models.each { |model|  model.create }
    return true
  end
  
  def my_update
    attributes  = get_uncomposed_attributes
    array_keys  = get_array_keys(attributes) 
    (0..get_maxsize_from_array_attributes(attributes)).each { |i|
      conditions = set_conditions_for_find_first_nogroup(attributes,array_keys,i)
      model = self.class.find(:first_nogroup, :conditions => conditions)
      my_create_or_update(attributes,i,model)
    }
    # Here is missing the destroy method to delete the unselected records.
    return true
  end
  
  def my_create_or_update(attributes, i, model=nil)
    if model != nil
      self.attributes = fill_model_to_update(attributes, i)
      model.update
    else
      new_model = fill_model(attributes, i) 
      new_model.create
    end
  end

  def get_uncomposed_attributes
    keys = (self.attribute_names - self.reserved_attributes) - self.primary_keys
    keys.inject({}) do |params, key|  
      params[key] = self.attributes_before_type_cast[key] 
      params
    end
  end

  def fill_models(attributes)
    (0..get_maxsize_from_array_attributes(attributes)).collect { |i| fill_model(attributes,i) }
  end
  
  def get_maxsize_from_array_attributes(attributes)
    array = attributes.values.collect! { |value| value.size if value.is_a?(Array) }.compact
    array.empty? ? 0 : array.sort.last - 1
  end 
  
  def fill_model(uattributes, i)
    model = self.class.new
    self.primary_keys.each { |key| model.[]=(key, self.attributes[key]) }
    uattributes.keys.each { |key| 
      next if key == 'id'
      (uattributes[key].is_a? Array) ? (model.[]=(key, uattributes[key][i])) : (model.[]=(key, uattributes[key]))
    }
    return model
  end

  def fill_model_to_update(attributes, i)
    attributes.keys.inject({}) do |params, key|  
      (attributes[key].is_a? Array) ? (params[key] = attributes[key][i]) : (params[key] = attributes[key])
      params
    end
  end
  
  def are_valid_models?(models)
    models.each { |model| return false unless model.valid? }
    return true
  end
  
  def get_array_keys(attributes)
    attributes.keys.collect! { |key| key if attributes[key].is_a? Array }.compact!
  end

  def set_conditions_for_find_first_nogroup(attributes, array_keys, i)
    keys = self.primary_keys + array_keys
    ids = self.ids.split(':')
    set_conditions(keys, ids) + array_keys.collect { |key| attributes[key][i] } 
  end
end

