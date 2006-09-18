class ModelComposedKeys < ActiveRecord::Base

  # Class Methods
  class << self
    def set_primary_keys(*keys)
      cattr_accessor :primary_keys, :reserved_attributes 
      self.primary_keys = keys.collect {|key| key.to_s}
      self.reserved_attributes = %w(created_on updated_on)
    end

    def find(*args)
      options = extract_options_from_args!(args)
      case args.first      
      when :first then find_first_composed_keys(options)
      when :all   then find_every_composed_keys(options)
      else             find_composed_keys(args.first)
      end
    end

    def set_conditions_for_primary_keys(ids)
      [ set_query(self.primary_keys) ] + ids.split(':') 
    end

    private
    def find_composed_keys(ids)
      set_ids(ids) # Used for destroy
      conditions = set_conditions_for_primary_keys(ids)
      record = find_initial({:conditions => conditions})
      attributes = (record.attribute_names - self.reserved_attributes) - self.primary_keys
      grouped_records = find_every({:select => attributes.join(','), :conditions => conditions})
      record = set_arrays_in_record(record, grouped_records, attributes)
      record.id = ids
      record
    end

    def set_query(keys)
      keys.collect { |key|  key.to_s + ' = ?' }.join(' AND ')
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

    def find_every_composed_keys(options)
      grouped_records = find_every({:select => self.primary_keys.join(','), 
                                     :group => self.primary_keys.join(',')})
      records = []
      grouped_records.each { |grouped_record|
        records << find_composed_keys(get_ids_from_record(grouped_record))
      }
      records
    end

    def find_first_composed_keys(options)
      record = find_initial({:conditions =>  options[:conditions]})
      grouped_records = find_every({:conditions => options[:conditions]})
      attributes = (record.attribute_names - self.reserved_attributes) - self.primary_keys
      record = set_arrays_in_record(record, grouped_records, attributes)
      record
    end

    def get_ids_from_record(record)
      self.primary_keys.collect { |key| record.send(key) }.join(':')
    end
    
  end

  # Instance Methods
  def destroy
    conditions = self.class.set_conditions_for_primary_keys(self.ids) 
    self.class.find(:all, :conditions => conditions).each { |object|
      super
      object.destroy
    }
  end

  def save 
    attributes = set_uncomposed_attributes
    models = fill_models(attributes)
    return false unless are_valid_models?(models)
    models.each { |model|
      model.create_or_update
    }
    return true
  end

  def update_attributes(attributes)
    self.save
  end

  private
  def set_uncomposed_attributes
    attributes = Hash.new
    ((self.attribute_names - self.reserved_attributes) - self.primary_keys).each { |key|
      attributes[key] = self.attributes_before_type_cast[key]
    }
    return attributes
  end

  def fill_models(attributes)
    models = []
    i = 0
    while  i <= get_max_array_size(attributes)
      models << fill_model(attributes, i)
      i = i + 1
    end
    models
  end
  
  def get_max_array_size(uncomposed_attributes)
    array = []
    uncomposed_attributes.map { |key,value|  array << value.size if value.is_a?(Array) }
    array.empty? ? 0 : array.sort.last - 1
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
  
  def are_valid_models?(models)
    models.each { |model| return false unless model.valid? }
    return true
  end
end
