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

  def finder_id(model, attributes, id)
    if id.nil?
      conditions = {}
    else
      conditions = { :conditions => "id = #{id}" }
    end
    Finder.new(model, attributes, :first, conditions).as_pair
  end

  def simple_select(object, model, tabindex, options={}, html_options={})
    column = options[:attribute] || ((model.column_names.include? 'title') ? 'title' : 'name')
    field = foreignize(model,options[:prefix])
    selected = selectize_id(@edit, field, options[:selected], @filter)
    @list = Finder.new(model, [ column ], :all, :order => "#{column} ASC").as_pair
    @list = @list + finder_id(model, [ column ], selected) if !selected.nil? && @list.rassoc(selected).nil?
    html_options[:tabindex] = tabindex
    select(object, field, @list, {:prompt => '-- Seleccionar --', :selected => selected},html_options)
  end

  def select_conditions(object, model, tabindex, options={}, html_options={})
    field = options[:field] || foreignize(model,options[:prefix])
    attributes = options[:attributes] || %w(name)
    selected = selectize_id(@edit, field, options[:selected], @filter)
    [:attributes, :selected, :field].each { |key| options.delete(key) }
    @list = Finder.new(model, attributes, :all, options).as_pair
    @list = @list + finder_id(model, attributes, selected) if !selected.nil? && @list.rassoc(selected).nil?
    html_options[:tabindex] = tabindex
    select(object, field, @list, {:prompt => '-- Seleccionar --', :selected => selected}, html_options)
  end

  def observable_select(partial, id, tabindex)
    render :partial => "salva/#{partial}", :locals => { :id => id, :tabindex => tabindex }
  end
end
