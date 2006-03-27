module SelectHelper   
  def simple_select(object, model, model_id)
    select(object, model_id,  
           model.find(:all, :order => 'name ASC').collect {
             |p| [ p.name, p.id ]
           },
           {:prompt => '-- Seleccionar --'})
  end
  
  def selected_select(object, model, model_id, id) 
    args = [ object, model_id, 
             model.find(:all, :order => 'name ASC').collect { 
               |p|[p.name, p.id]
             }, 
             id ]
    select = "<select name=\"#{object}[#{model_id}]\">" 
    select += "<option>-- Seleccionar --</option> \n" 
    select += options_for_select(*args.to_a) + "\n</select>"
  end    
  
  def table_select(object, model, opts={})
    model_id = model.name.downcase+'_id'      
    if opts[:prefix] then
      model_id = opts[:prefix]+'_'+model.name.downcase+'_id'
    end
    if (opts[:id] != nil) then
      selected_select(object, model, model_id, opts[:id])
    else
      simple_select(object, model, model_id)
    end       
  end

  def select2update_select(object, model, opts={}, dest={})
    model_id = model.name.downcase + '_id'      
    model_id = opts[:prefix] + '_' + model_id if opts[:prefix] !=nil
    select(object, model_id,  
           model.find(:all, :order => 'name ASC').collect {
             |p| [ p.name, p.id ]
           }, 
           { :prompt => '-- Seleccionar --' },
           { :onchange => remote_functag(model.name, dest[:model], dest[:prefix]) }
           )
  end

  def remote_functag(origmodel, destmodel, prefix=nil)
    model_id = destmodel.downcase + '_id'
    model_id = prefix + '_' + model_id if prefix != nil
    origmodel = origmodel.downcase
    destmodel = destmodel.downcase

    withparams = "'template=select_#{origmodel}_#{destmodel}&id='+value"
    div_note = model_id + '_note'
    success_msg = "new Effect.BlindUp('#{div_note}', {duration: 0.10}); "
    success_msg += "return false;"
    loading_msg = "Toggle.display('#{div_note}');"

    remote_function(:update => model_id, 
                    :url => {:action => :update_select_dest},
                    :with => withparams, :loading => loading_msg,
                    :success => success_msg)
  end
  
  def bycondition_select(object, model, opts={}, dest={} )
    model_id = model.name.downcase+'_id'
    model_id = opts[:prefix] + '_' + model_id if opts[:prefix] != nil

    conditions = [ opts[:belongs_to] + ' = ?', opts[:id] ]
    
    params = [ object, model_id, 
               model.find(:all, :order => 'name ASC', 
                          :conditions => conditions).collect {
                 |p| [ p.name, p.id ]
               }, 
               {:prompt => '-- Seleccionar --'} 
             ]
    
    if dest[:model] then
      params << {:onchange => remote_functag(model.name,
                                             dest[:model],
                                             dest[:prefix]) }
    end
    select(*params.to_a)
  end
end
