module SelectHelper   
  def simple_select(object, model, model_id, rparams=nil)
    params = [ object, model_id,  
               model.find(:all, :order => 'name ASC').collect {|p| [ p.name, p.id ]}, 
               {:prompt => '-- Seleccionar --'} ]
    
    params.push({:onchange => remote_function_tag(*rparams.to_a)}) if rparams.length > 0
  end
  
  def conditional_select(object, model, model_id, condition_id, ref_model, rparams=nil)
    conditions = [ ref_model + ' = ?', condition_id ]
    params = [ object, model_id, 
               model.find(:all, :order => 'name ASC', 
                          :conditions => conditions).collect {|p| [ p.name, p.id ]}, 
               {:prompt => '-- Seleccionar --'} ]
    params.push({:onchange => remote_function_tag(*rparams.to_a)}) if rparams.length > 0
  end
  
  def selected_select(object, model, model_id) 
    [ model.find(:all, :order => 'name ASC').collect {|p| [ p.name, p.id ]}, id ]
  end
  
  def selectedref_select(object, model, model_id, ref_model, condition_id) 
    conditions = [ ref_model + ' = ?', condition_id ]
    [ model.find(:all, :order => 'name ASC', 
                 :conditions => conditions).collect { |p| [ p.name, p.id ]}, 
      id ]
  end
  
  def selected_select
    select = "<select name=\"#{object}[#{model_id}]\" " 
    select += rparams.length > 0 ? 'onchange="' + remote_function_tag(*rparams.to_a) + '">' : '>' 
    select += "<option>-- Seleccionar --</option> \n" + options_for_select(*params.to_a) + "\n</select>"
  end
  
  def table_select(object, model, options={}, remote={}, conditions={})
    options = options.stringify_keys
    prefix = nil
    model_id = model.name.downcase+'_id'      
    if options['prefix'] then
      model_id = options['prefix']+'_'+model.name.downcase+'_id'
      prefix = options['prefix']
    end
    
    remote = remote.stringify_keys    
    rparams = []
    if remote['div'] and remote['model']
      rparams = [ remote['div'], "model=#{remote['model']}&div=#{remote['div']}&ref_model=#{model_id}&id='+value",  prefix]
    end
    
    conditions = conditions.stringify_keys
    if (options['id'] != nil) then
      select_selected(object, model, model_id, options['id'], conditions['ref_model'], conditions['id'], rparams)
    else
      select_simple(object, model, model_id, conditions['ref_model'], conditions['id'], rparams)
    end       
  end
end
