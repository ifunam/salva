require 'list_helper'
require 'application_helper'
module SelectHelper   
  
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
    model_id = model_id(model)
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
    model_id = model_id(opts[:model])
    model_id = opts[:prefix] + '_' + model_id if opts[:prefix] !=nil
    select(opts[:object], model_id, sorted_find(opts[:model]), { :prompt => '-- Seleccionar --' }, { :onchange => remote_functag(opts[:model].name, dest[:model], dest[:prefix]) })
  end

  def bycondition_select(opts={}, dest={} )
    model_id = model_id(opts[:model])
    model_id = opts[:prefix] + '_' + model_id if opts[:prefix] != nil

    conditions = [ opts[:belongs_to] + ' = ?', opts[:id] ]
    
    params = [ opts[:object], model_id, sorted_find(opts[:model]), {:prompt => '-- Seleccionar --'} ]
    
    if dest[:model] then
      params << {:onchange => remote_functag(opts[:model].name, dest[:model],
                                             dest[:prefix]) }
    end
    select(*params.to_a)
  end

  
  def byattr_select(object, model, model_id, opts={})
    select(object, model_id, sorted_find(model, opts[:attr]), {:prompt => '-- Seleccionar --'},  {:tabindex => opts[:tabindex] })
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
    if columns.include? 'parent_id' then
      fieldname = 'parent_id' 
    else
      fieldname = model_id(model)
    end
    list = list_collection(collection, columns)
    select(object, fieldname, list, {:prompt => '-- Seleccionar --'}, opts)
  end
end  
