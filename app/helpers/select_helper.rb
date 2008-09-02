require 'finder'
module SelectHelper

  def selectize_id(object, field, selected=nil, filter={})
    selected_id = nil
    # Default value from filter has priority over defined state_id or selected option
    if filter.is_a? Hash and filter.has_key?(field) and !filter[field].nil?
      selected_id = filter[field]
    elsif !object.nil? and object.respond_to? field and !object.send(field).nil?
      selected_id = object.send(field)
    elsif !selected.nil?
      selected_id = selected.to_i
    end
    selected_id = selected_id.to_i if selected_id.is_a? String and !selected_id.strip.empty?
    selected_id.to_i if !selected_id.nil? and selected_id.to_i > 0
  end

  def finder_id(model, id, attributes=[])
    if id == :first || id == :last
      options = { }
    else
      options = { :conditions => "#{Inflector.tableize(model).pluralize}.id = #{id}" }
    end

    unless attributes.nil? or attributes.empty?
      if attributes.is_a? Array
        options[:attributes] = attributes
      else
        options[:column] = attributes
      end
    end
    Finder.new(model, :first, options).as_pair
  end

  def foreignize(model, prefix=nil)
    (prefix != nil) ? prefix + '_' +  Inflector.foreign_key(model) : Inflector.foreign_key(model)
  end

  def simple_select(model, options)
    model = Inflector.tableize(model).classify.constantize
    field = options[:field] || foreignize(model,options[:prefix])
    selected = selectize_id(eval("@#{object_name}"), field, options[:default].to_i, @filter)  unless @object_name.nil?
    selected = selectize_id(@object, field, options[:default].to_i, @filter) if selected.nil?
    list = Finder.new(model, options).as_pair
    selected = list.first[0] if selected == :first
    selected = list.last[0] if selected == :last
    list += finder_id(model, selected, options[:attributes])  if !selected.nil? && list.rassoc(selected.to_i).nil?
    object_name = @object_name.nil? ? options[:object_name] : @object_name
    @template.select(object_name, field, list, { :prompt => '-- Seleccionar --', :selected => selected})
  end


  def select_conditions(model, options)
    model = Inflector.tableize(model).classify.constantize
    field = options[:field] || foreignize(model,options[:prefix])
    object_name = @object_name.nil? ? options[:object_name] : @object_name
    selected = selectize_id(eval("@#{object_name}"), field, options[:default], @filter) unless @object_name.nil?
    selected = selectize_id(@object, field, options[:default], @filter) if selected.nil?
    list = Finder.new(model, :all, options).as_pair
    list += finder_id(model, selected, options[:attributes])  if !selected.nil? && list.rassoc(selected.to_i).nil?
    object_name = @object_name.nil? ? options[:object_name] : @object_name
    @template.select(object_name, field, list, { :prompt => '-- Seleccionar --', :selected => selected})
  end

end
