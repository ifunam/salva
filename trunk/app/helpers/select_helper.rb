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

  def select2update_select(object, model, opts={})
    model_id = model.name.downcase+'_id'      
    if opts[:prefix] then
      model_id = opts[:prefix]+'_'+model.name.downcase+'_id'
    end
    select(object, model_id,  
           model.find(:all, :order => 'name ASC').collect {
             |p| [ p.name, p.id ]
           }, 
           { :prompt => '-- Seleccionar --' },
           { :onchange => remote_functag(model, opts[:destmodel],
                                        opts[:destprefix]) }
           )
  end

  def remote_functag(origmodel, destmodel, destprefix=nil)
    destmodel_id = destmodel.downcase + '_id'
    destmodel_id = destprefix + '_' + destmodel_id if destprefix != nil
    div = destmodel_id 
    div_note = div + '_note'

    withparams = "'destmodel=#{destmodel}&origmodel=#{origmodel}&id='+value"
    success_msg = "new Effect.BlindUp('#{div_note}', {duration: 0.10}); "
    success_msg += "return false;"
    loading_msg = "Toggle.display('#{div_note}');"

    remote_function(:update => div, :url => {:action => :update_select_dest},
                    :with => withparams, :loading => loading_msg,
                    :success => success_msg)
  end
  
  def bycondition_select(object, model, opts={} )
    model_id = model.name.downcase+'_id'
    if opts[:prefix] then
      model_id = opts[:prefix]+'_'+model.name.downcase+'_id'
    end
    
    belongs_to = opts[:belongs_to].downcase + '_id'
    conditions = [ belongs_to + ' = ?', opts[:id] ]
    
    params = [ object, model_id, 
               model.find(:all, :order => 'name ASC', 
                          :conditions => conditions).collect {
                 |p| [ p.name, p.id ]
               }, 
               {:prompt => '-- Seleccionar --'} 
             ]
    
    if opts[:destmodel] and opts[:destprefix] then
      params << {:onchange => remote_functag(model, opts[:destmodel],
                                             opts[:destprefix]) }
    end
    select(*params.to_a)
  end
end
