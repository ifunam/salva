require 'finder'
require 'application_helper'
require 'labels'
module SelectHelper
  include ApplicationHelper
  include Labels
  include ActionView::Helpers::FormOptionsHelper

  def selectize_id(object, field, selected=nil, filter={})
    # Default value from filter has priority over defined state_id or selected option
    if filter.is_a? Hash and filter.has_key?(field) and !filter[field].nil?
      if filter[field].is_a? String
         filter[field] if !filter[field].strip.empty?
       else
         filter[field]
       end
    elsif !object.nil? and object.respond_to? field and !object.send(field).nil?
      if object.send(field).is_a? String
        object.send(field).to_i if !object.send(field).strip.empty?
      else
        object.send(field)
      end
    elsif !selected.nil?
      selected
    end
  end

  def finder_id(model, id, attributes=[])
    options = { :conditions => "#{Inflector.tableize(model).pluralize}.id = #{id}" }
    unless attributes.nil? or attributes.empty?
      if attributes.is_a? Array
        options[:attributes] = attributes
      else
        options[:column] = attributes
      end
    end
    Finder.new(model, :first, options).as_pair
  end

  def simple_select(object, model, tabindex, options={})
    field = options[:field] || foreignize(model,options[:prefix])
    selected = selectize_id(@edit, field, options[:selected], @filter)
    @list = Finder.new(model, options).as_pair
    @list = @list + finder_id(model, selected, options[:column]) if !selected.nil? && @list.rassoc(selected).nil?
    select(object, field, @list, {:prompt => '-- Seleccionar --', :selected => selected}, {:tabindex => tabindex})
  end

  def select_conditions(object, model, tabindex, options={})
    field = options[:field] || foreignize(model,options[:prefix])
    selected = selectize_id(@edit, field, options[:selected], @filter)
    @list = Finder.new(model, :all, options).as_pair
    @list = @list + finder_id(model, selected, options[:attributes]) if !selected.nil? && @list.rassoc(selected).nil? && options.has_key?(:attributes)
    select(object, field, @list, {:prompt => '-- Seleccionar --', :selected => selected}, {:tabindex => tabindex})
  end

  def observable_select(partial, id, tabindex)
    render :partial => "salva/#{partial}", :locals => { :id => id, :tabindex => tabindex }
  end

  def simple_observable_select(partial, id, tabindex)
    model = Inflector.camelize(partial.split('_').last).constantize
    column = foreignize(partial.split('_')[1])
    render :partial => "salva/simple_observable_select", :locals => { :id => id, :tabindex => tabindex, :model => model, :column => column}
  end
end
