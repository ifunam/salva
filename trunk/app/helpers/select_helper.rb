require 'table_helper'
module SelectHelper   
  include TableHelper

  def sorted_find(model)
    sorted_list(model.find(:all, :order => 'name ASC').collect! { |p| 
                  [ p.name, p.id ] if p.name.length > 0
                })
  end
  
  def simple_select(object, model, model_id, tabindex=nil, required=nil)
    opts = { :tabindex => tabindex }
    if required == 1
      opts['z:required'] = 'true' 
      opts['z:required_message'] = 'Seleccione una opción'
    end
    select(object, model_id, sorted_find(model), {:prompt => '-- Seleccionar --'}, opts)
  end
  
  def selected_select(object, model, model_id, id, tabindex=nil, required=nil) 
    args = [ object, model_id, sorted_find(model), id ]
    select = "<select name=\"#{object}[#{model_id}]\" "
    if tabindex
      select += "tabindex=\"#{tabindex}\" " 
    end
    if required == 1
      select +='z:required="true" z:required_message="Seleccione una opción" ' 
    end
    select += ">"
    
    select += "<option>-- Seleccionar --</option> \n" 
    select += options_for_select(*args.to_a) + "\n</select>"
  end    
  
  def table_select(object, model, opts={})
    model_id = model.name.downcase+'_id'      
    if opts[:prefix] then
      model_id = opts[:prefix]+'_'+model.name.downcase+'_id'
    end
    if (opts[:id] != nil) then
      selected_select(object, model, model_id, opts[:id], 
                      opts[:tabindex], opts[:required])
    else
      simple_select(object, model, model_id, opts[:tabindex], opts[:required])
    end       
  end

  def select2update_select(opts={}, dest={})
    model_id = opts[:model].name.downcase + '_id'      
    model_id = opts[:prefix] + '_' + model_id if opts[:prefix] !=nil
    select(opts[:object], model_id, sorted_find(opts[:model]), { :prompt => '-- Seleccionar --' }, { :onchange => remote_functag(opts[:model].name, dest[:model], dest[:prefix]) })
  end

  def bycondition_select(opts={}, dest={} )
    model_id = opts[:model].name.downcase+'_id'
    model_id = opts[:prefix] + '_' + model_id if opts[:prefix] != nil

    conditions = [ opts[:belongs_to] + ' = ?', opts[:id] ]
    
    params = [ opts[:object], model_id, sorted_find(opts[:model]), {:prompt => '-- Seleccionar --'} ]
    
    if dest[:model] then
      params << {:onchange => remote_functag(opts[:model].name, dest[:model],
                                             dest[:prefix]) }
    end
    select(*params.to_a)
  end

  def sorted_find_byattribute(model, attr='name')
    sorted_list(model.find(:all, :order => 'name ASC').collect { |p| 
                  if p.send( opts[:attr] || attr).length != 0 
                    [ p.send( opts[:attr] || attr), p.id ] 
                  end
                }.compact!)
  end
  
  def byattr_select(object, model, model_id, opts={})
    select(object, model_id, sorted_find_byattribute(model, opts[:attr]), {:prompt => '-- Seleccionar --'},  {:tabindex => opts[:tabindex] })
    
  end

  def remote_functag(origmodel, destmodel, prefix=nil)
    partial = "select_#{origmodel.downcase}_#{destmodel.downcase}" 
    partial += "_prefix" if prefix 
    
    params = "'partial=#{partial}&id='+value"
    partial_note =  partial + "_note"
    success_msg = "Effect.BlindUp('#{partial_note}', {duration: 0.5});; "
    success_msg += "return false;"
    loading_msg = "Toggle.display('#{partial_note}');"

    remote_function(:update => partial, :with => params, 
                    :url => {:action => :update_select},
                    :loading => loading_msg,
                    :success => success_msg)
  end

  def tree_select(object, model, columns, opts={})
    opts['z:required'] = 'true' 
    opts['z:required_message'] = 'Seleccione una opción'
    collection = model.find(:all)
    list = list_collection(collection, columns)
    select(object, model.name.downcase + '_id', list, {:prompt => '-- Seleccionar --'}, opts)
  end
end  
