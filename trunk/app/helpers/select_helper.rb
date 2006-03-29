module SelectHelper   
  def simple_select(object, model, model_id, tabindex=nil)
    select(object, model_id,  
           model.find(:all, :order => 'name ASC').collect {
             |p| [ p.name, p.id ]
           },
           {:prompt => '-- Seleccionar --'}, 
           {:tabindex => tabindex })

  end
  
  def selected_select(object, model, model_id, id, tabindex=nil) 
    args = [ object, model_id, 
             model.find(:all, :order => 'name ASC').collect { 
               |p|[p.name, p.id]
             }, 
             id ]
    select = "<select name=\"#{object}[#{model_id}]\""
    tabindex ? select += "tabindex=\"#{tabindex}\">" : ">"
    select += "<option>-- Seleccionar --</option> \n" 
    select += options_for_select(*args.to_a) + "\n</select>"
  end    
  
  def table_select(object, model, opts={})
    model_id = model.name.downcase+'_id'      
    if opts[:prefix] then
      model_id = opts[:prefix]+'_'+model.name.downcase+'_id'
    end
    if (opts[:id] != nil) then
      selected_select(object, model, model_id, opts[:id], opts[:tabindex])
    else
      simple_select(object, model, model_id, opts[:tabindex])
    end       
  end

  def select2update_select(opts={}, dest={})
    model_id = opts[:model].name.downcase + '_id'      
    model_id = opts[:prefix] + '_' + model_id if opts[:prefix] !=nil
    select(opts[:object], model_id,  
           opts[:model].find(:all, :order => 'name ASC').collect {
             |p| [ p.name, p.id ]
           }, 
           { :prompt => '-- Seleccionar --' },
           { :onchange => remote_functag(opts[:model].name, dest[:model], 
                                         dest[:prefix]) }
           )
  end

  def bycondition_select(opts={}, dest={} )
    model_id = opts[:model].name.downcase+'_id'
    model_id = opts[:prefix] + '_' + model_id if opts[:prefix] != nil

    conditions = [ opts[:belongs_to] + ' = ?', opts[:id] ]
    
    params = [ opts[:object], model_id, 
               opts[:model].find(:all, :order => 'name ASC', 
                          :conditions => conditions).collect {
                 |p| [ p.name, p.id ]
               }, 
               {:prompt => '-- Seleccionar --'} 
             ]
    
    if dest[:model] then
      params << {:onchange => remote_functag(opts[:model].name, dest[:model],
                                             dest[:prefix]) }
    end
    select(*params.to_a)
  end

  def remote_functag(origmodel, destmodel, prefix=nil)
    model_id = destmodel.downcase + '_id'
    model_id = prefix + '_' + model_id if prefix != nil
    origmodel = origmodel.downcase
    destmodel = destmodel.downcase
    
    template = "select_#{origmodel}_#{destmodel}" 
    template += "_prefix" if prefix != nil
    
    params = "'template=#{template}&id='+value"
    div_note = model_id + '_note'
    success_msg = "new Effect.BlindUp('#{div_note}', {duration: 0.5}); "
    success_msg += "return false;"
    loading_msg = "Toggle.display('#{div_note}');"

    remote_function(:update => model_id, 
                    :url => {:action => :update_select_dest},
                    :with => params, :loading => loading_msg,
                    :success => success_msg)
  end

  def byattr_select(object, model, model_id, opts={})
    attr = 'name'
    select(object, model_id,  
           model.find(:all, :order => 'name ASC').collect {
             |p| [ p.send( opts[:attr] || attr), p.id ]
           },
           {:prompt => '-- Seleccionar --'}, 
           {:tabindex => opts[:tabindex] })

  end
end
