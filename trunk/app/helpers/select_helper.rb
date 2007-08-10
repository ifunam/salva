require 'finder'
require 'list_helper'
require 'application_helper'
require 'labels'
module SelectHelper
  include ApplicationHelper
  include Labels
  include ActionView::Helpers::FormOptionsHelper

  def selectize_id(object, field, selected=nil, filter={})
    # Default value from filter has priority over defined state_id or selected option
    if filter.is_a? Hash and filter.has_key?(field) and !filter[field].nil?
      filter[field]
    elsif !object.nil? and object.respond_to? field and !object.send(field).nil?
      object.send(field)
    elsif !selected.nil?
      selected
    end
  end

  def finder_id(model, attributes, id)
    Finder.new(model, attributes, :first, :conditions => "id = #{id}").as_pair
  end

  def simple_select(object, model, tabindex, options={})
    column = options[:attribute] || ((model.column_names.include? 'title') ? 'title' : 'name')
    field = foreignize(model,options[:prefix])
    selected = selectize_id(@edit, field, options[:selected], @filter)
    @list = Finder.new(model, [ column ], :all, :order => "#{column} ASC").as_pair
    @list = @list + finder_id(model, [ column ], selected) if !selected.nil? && @list.rassoc(selected).nil?
    select(object, field, @list, {:prompt => '-- Seleccionar --', :selected => selected},  { :tabindex => tabindex})
  end

  def select_conditions(object, model, tabindex, options={})
    field = options[:field] || foreignize(model)
    attributes = options[:attributes] || %w(name)
    selected = selectize_id(@edit, field, options[:selected], @filter)
     [:attributes, :selected, :field].each { |key| options.delete(key) }
    @list = Finder.new(model, attributes, :all, options).as_pair
    @list = @list + finder_id(model, attributes, selected) if !selected.nil? && @list.rassoc(selected).nil?
    select(object, field, @list, {:prompt => '-- Seleccionar --', :selected => selected}, {:tabindex => tabindex})
  end

  def observable_select(partial, id, tabindex)
    render :partial => "salva/#{partial}", :locals => { :id => id, :tabindex => tabindex }
  end

  def select_as_tree(object, model, columns, tabindex, validation_type=nil, conditions=nil)
    options = set_options_tags(tabindex, validation_type)
    collection = model.find(:all, conditions)
    list = list_collection(collection, columns)
    fieldname = foreignize(model)
    fieldname = 'parent_id' if columns.include? 'parent_id'
    select(object, fieldname, list, {:prompt => '-- Seleccionar --'}, options)
  end

  def select_adscription(object, model, tabindex, validation_type=nil)
    options = set_options_tags(tabindex, validation_type)
    institution = get_myinstitution
    if institution.id != nil
      list = list_from_collection(model.find(:all, :order => 'name DESC', :conditions => [ 'institution_id = ?', institution.id]))
    else
      list = list_from_collection(model.find(:all, :order => 'name DESC'))
    end
    select(object, foreignize(model), list, {:prompt => '-- Seleccionar --'}, options)
  end

  def select_without_universities(object, model, tabindex, validation_type=nil)
    options = set_options_tags(tabindex, validation_type)
    list = list_from_collection(model.find(:all, :order => 'name DESC', :conditions => [ 'institutiontitle_id != ?', 1]))
    select(object, foreignize(model), list, {:prompt => '-- Seleccionar --'}, options)
  end

  def select_institution(object, model, tabindex, validation_type=nil)
    options = set_options_tags(tabindex, validation_type)
    list = list_from_collection(model.find(:all, :order => 'name DESC', :conditions => [ 'institution_id = ?', 1]))
    select(object, foreignize(model), list, {:prompt => '-- Seleccionar --'}, options)
  end

  def set_options_tags(tabindex, validation_type=nil)
    options = Hash.new
    options[:tabindex] = tabindex
    options
  end
end
