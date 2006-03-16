module SelectHelper   
  def simple_select(object, model, model_id)
    args = [ object, model_id,  
             model.find(:all, :order => 'name ASC').collect {|p| [ p.name, p.id ]}, 
             {:prompt => '-- Seleccionar --'} ]
    select(*args.to_a)
  end

  def selected_select(object, model, model_id, id) 
    args = [ object, model_id, 
             model.find(:all, :order => 'name ASC').collect {|p| [ p.name, p.id ]}, 
             id ]
    select = "<select name=\"#{object}[#{model_id}]\">" 
    select += "<option>-- Seleccionar --</option> \n" 
    select += options_for_select(*args.to_a) + "\n</select>"
  end    
  
  def table_select(object, model, options={})
    model_id = model.name.downcase+'_id'      
    if options[:prefix] then
      model_id = options[:prefix]+'_'+model.name.downcase+'_id'
    end
    if (options[:id] != nil) then
      selected_select(object, model, model_id, options[:id])
    else
      simple_select(object, model, model_id)
    end       
  end

  def list2update_select(object, model, options={})
    model_id = model.name.downcase+'_id'      
    if options[:prefix] then
      model_id = options[:prefix]+'_'+model.name.downcase+'_id'
    end
    destmodel = options[:destmodel]
    destmodel_id = destmodel.downcase + '_id'
    destmodel_id = options[:destprefix] + '_' + destmodel_id if options[:prefix] != nil
    args = [ object, model_id,  
             model.find(:all, :order => 'name ASC').collect {|p| [ p.name, p.id ]}, 
             {:prompt => '-- Seleccionar --'} ]
    args << {:onchange => remote_functag(model, destmodel, destmodel_id)} 
    select(*args.to_a)
  end

  def remote_functag(model, destmodel, destmodel_id)
    div = destmodel_id + '_note'
    with = "'destmodel=#{destmodel}&div=#{div}&origmodel=#{model}&id='+value"
    success_msg = "new Effect.BlindUp('#{div}', {duration: 0.4}); return false;"
    loading_msg = "Toggle.display('#{div}')",
    remote_function(:update => div, :with => with, 
                    :url => {:action => :upgrade_select_dest},  
                    :loading => loading_msg,
                    :success => success_msg)
  end

  #def bycondition_select(object, model, model_id, condition_id, ref_model, rargs=nil)
  #  conditions = [ ref_model + ' = ?', condition_id ]
  #args = [ object, model_id, 
  #           model.find(:all, :order => 'name ASC', 
  #                      :conditions => conditions).collect {|p| [ p.name, p.id ]}, 
  #           {:prompt => '-- Seleccionar --'} ]
  #end
  
#   def condiselected_select(object, model, model_id, ref_model, condition_id, rargs=nil) 
#     conditions = [ ref_model + ' = ?', condition_id ]
#     args = [ object, model_id, 
#              model.find(:all, :order => 'name ASC', 
#                         :conditions => conditions).collect { |p| [ p.name, p.id ]}, 
#              id ]
#     select = "<select name=\"#{object}[#{model_id}]\" " 
#     select += rargs.length > 0 ? 'onchange="' + remote_functag(*rargs.to_a) + \
#     '">' : '>' 
#     select += "<option>-- Seleccionar --</option> \n" 
#     select += options_for_select(*args.to_a) + "\n</select>"
#   end
  
end
