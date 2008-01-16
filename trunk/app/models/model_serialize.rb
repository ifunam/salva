class ModelSerialize
  attr_accessor :klasses
  attr_accessor :records
  attr_accessor :model
  attr_accessor :user_id
  attr_accessor :moduser_id
  attr_accessor :parent

  def initialize(klasses, id=nil)
    @klasses = klasses
    if id.nil?
      @records = klasses.flatten.inject({}) { |h, model| h[attribute_name(model)] = model.new;  h }
    else
      @model = @klasses.shift.find(id)
      @records = { attribute_name(@model.class.name)  => @model }
      fill_from_record(@model, *@klasses)
    end
  end

  def fill(params)
    @records.keys.each  do |k|
      set_attributes(@records[k],  params[k])
    end
    @model = prepare_record
  end

  def set_attributes(model, attributes)
    attributes.keys.each { |k| model.[]=(k, attributes[k]) } if attributes.is_a? Hash
    model.user_id = self.user_id  if model.has_attribute? 'user_id' and !self.user_id.nil?
    model.moduser_id = self.moduser_id if model.has_attribute? 'moduser_id' and !self.moduser_id.nil?
  end

  def valid?
    @model.valid?
  end

  def errors
    @model.errors
  end

  def save
    @model.save if @model.valid?
  end
  
  def update_models
    @records.values.each do |record|
      record.save if record.valid?
    end
  end

  def id
    @model.id
  end

  def prepare_record
    myklasses = *@klasses
    record_array = walk_array(myklasses)
    record_array.reverse.each do |model, index|
       record_array[index].first.send(attribute_name(model.class.name).to_s + '=', model) unless index.nil?
    end
     record_array[0].first
  end

  def walk_array(models, index=nil)
    m = [ [@records[attribute_name(models.shift)], index] ]
    index = (index.nil?) ? 0 : (index += 1)
    models.collect do |model|
      if model.is_a? Array
        m += walk_array(model, index)
      else
        m << [@records[attribute_name(model)], index]
      end
    end
    m
  end
  
  def fill_from_record(record, *models)
      models.each do |model|
       if model.is_a? Array
         myrecord = record.send(attribute_name(model.shift))
         @records[attribute_name(myrecord.class.name)] = myrecord
         fill_from_record(myrecord, *model)
       else
         m = attribute_name(model)
         @records[m] = record.send(m.to_s)
       end
     end
  end

  def attribute_name(m)
    Inflector.underscore(m).pluralize.singularize.to_sym
  end
end
    
    
