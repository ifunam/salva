class ModelDependentMapper

  def initialize(models)
    @owner_klass = models.shift
    @sequence = models.shift
    @records = {}
  end
  
  def set_attributes(params)
    [@owner_klass, @sequence].flatten.each do |klass|
      key = ActiveSupport::Inflector.underscore(klass).to_sym
      @records[key] = record_loader(klass, params[key]) if params.has_key? key
      @owner = @records[key] if klass == @owner_klass 
    end
  end
  
  def set_user(user_id)
    @owner.user_id = user_id
  end
  
  def find(id, user_id)
     parent = @owner_klass.find_by_id_and_user_id(:first, id, user_id)
     @records[ActiveSupport::Inflector.underscore(@owner_klass).to_sym] = parent
     sequence_loader(@secuence, parent)
     @records
  end

  def all(user_id)
     @owner_klass.paginate(:conditions => {:user_id => user_id})
  end
  
  def save
    dependent_mapper(@sequence, @owner)
    @owner.save if @owner.valid?
  end

  def update
    dependent_mapper(@sequence, @owner)
    @owner.save if @owner.valid?
  end

  def valid?
    @owner.valid?
  end

  def errors
    @owner.errors
  end
  
  def records
     @records unless @records.empty?
  end
  
  private

  def record_loader(model_klass, hash)
    model_klass.exists?(hash) ? model_klass.first(:conditions => hash) : model_klass.new(hash)
  end
  
  def dependent_mapper(sequence, parent)
    sequence.each do |model|
       if model.is_a? Array
         dependent_mapper(model, parent)
       else
         k = ActiveSupport::Inflector.underscore(model).to_sym
         parent.send("#{k.to_s}=", @records[k])
         parent = @records[k]
       end
    end
   end
   
   def sequence_loader(sequence, parent)
     sequence.flatten.each do |klass|
       key = ActiveSupport::Inflector.underscore(klass).to_sym
       if klass.is_a? Array
         lazzy_loader(sequence, parent)
       else
         @records[key]  = parent.send(key)
       end
    end
   end
end
