# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper 
  def action_link(action, id, alt, question=nil)
    image ='/images/invisible_16x16.png'
    miceover = "return overlib('#{alt}', WIDTH, 20, HEIGHT, 20, RIGHT, BELOW, "
    miceover += "SNAPX, 2, SNAPY, 2)"
    miceout = "return nd()" 
    link_options = { :action => action, :id => id}
    html_options = { :class => action, :onmouseover => miceover, :onmouseout => miceout }
    html_options[:confirm] = question if question != nil
    
    link_to(image_tag(image, :size => '16x16', :border => 0, :alt => alt), 
            link_options, html_options )
  end
  
  def show_link(id)
    action_link('show', id, 'Mostrar')
  end
  
  def edit_link(id)
    action_link('edit', id, 'Modificar')
  end
  
  def purge_link(id,question)
    action_link('purge', id, 'Borrar', question)
  end
  
  
  def select_simple(object, model, model_id, rparams=nil)
    params = [ object, model_id,  
               model.find(:all, :order => 'name ASC').collect {|p| [ p.name, p.id ]}, 
               {:prompt => '-- Seleccionar --'} ]
   
    params.push({:onchange => remote_function_tag(*rparams.to_a)}) if rparams.length > 0
    select(*params.to_a)    
  end

  def select_condition(object, model, model_id, condition_id, ref_model, rparams=nil)
    condition = ref_model + ' = ?'
    params = [ object, model_id, 
               model.find(:all, :order => 'name ASC', 
                          :conditions => [ condition,condition_id ]
                          ).collect {|p| [ p.name, p.id ]}, 
               {:prompt => '-- Seleccionar --'} ]
    params.push({:onchange => remote_function_tag(*rparams.to_a)}) if rparams.length > 0
    select(*params.to_a)    
  end
  
  def select_selected(object, model, model_id, id, ref_model=nil, condition_id=nil, rparams=nil) 
    params = [ model.find(:all, :order => 'name ASC').collect {|p| [ p.name, p.id ]}, id ]
    if ref_model and condition_id then
      params = [ model.find(:all, :order => 'name ASC', :conditions => [ ref_model + ' = ?', conditions_id ]).collect {|p| [ p.name, p.id ]}, id ]
    end
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

  def check_box(object, id, checked=false, prefix='item_id')
    check_box_tag("#{object}[#{prefix}][]", id, checked = false, 
                  options = {:id => prefix}) 
  end
  
  def check_box_group(object, model, options={})
    options = options.stringify_keys
    prefix = model.name.downcase+'_id'      
    if options['prefix'] then
      prefix = options['prefix']+'_'+model.name.downcase+'_id'
    end
    ckbox_group = "<ul>\n"
    model.find(:all, :order => 'name ASC').collect { |m| 
      ckbox_group += '<li>' + check_box_tag("#{object}[#{prefix}][]", m.id, checked = false, options = {:id => prefix})  + m.name + "</li>\n"
    }
    ckbox_group += "</ul>\n"
    ckbox_group
  end

  def remote_function_tag(div, with, prefix=nil)
    prefix ?  with = "'prefix=#{prefix}&#{with}" :  with = "'#{with}" 
    remote_function(:update => div, :with => with, :url => {:action => :upgrade_select_dest},  
                    :loading => "Toggle.display('#{div}_note')",
                    :success => "new Effect.BlindUp('#{div}_note', {duration: 0.4}); return false;")
  end
  
  def remote_upgrade_select(model, name, question='¿Desea agregar este elemento?', options={}) 
    options = options.stringify_keys
    if ( options['prefix'] == nil ) then
      div2upgrade = model.downcase.to_s+'_id'
      field = model.downcase
      "if (handleKeyPress(event) && checkString(document.forms[0].#{field}_#{name}.value)) { var agree=confirm('#{question}'); if (agree) {new Ajax.Updater('#{div2upgrade}', '/wizard/upgrade_select?class=#{model}&name='+document.forms[0].#{field}_#{name}.value, {asynchronous:true, evalScripts:true}); return false;} }"
    else 
      prefix = options['prefix']
      div2upgrade = options['prefix']+'_'+model.downcase.to_s+'_id'
      field = options['prefix']+'_'+model.downcase
      "if (handleKeyPress(event) && checkString(document.forms[0].#{field}_#{name}.value)) { var agree=confirm('#{question}'); if (agree) {new Ajax.Updater('#{div2upgrade}', '/wizard/upgrade_select?class=#{model}&prefix=#{prefix}&name='+document.forms[0].#{field}_#{name}.value, {asynchronous:true, evalScripts:true}); return false;} }"
    end
  end
  
  def quickpost(partial)
    link_to_function(image_tag('add.gif', {:border=>0, :valign => 'middle', :alt=> 'Agregar'}), toggle_effect(partial, 'Effect.BlindUp', "duration:0.4", "Effect.BlindDown", "duration:0.4"))    
  end

  def toggle_effect(domid, true_effect, true_opts, false_effect, false_opts)
    "$('#{domid}').style.display == 'none' ? new #{false_effect}('#{domid}', {#{false_opts}}) : new #{true_effect}('#{domid}', {#{true_opts}}); return false;"
  end
  
  # This can be moved into application_helper.rb
  def loading_indicator_tag(scope,id)
    "<img src=\"/images/indicator.gif\" style=\"display: none;\" id=\"#{scope}-#{id}-loading-indicator\" alt=\"loading indicator\" class=\"loading-indicator\" />"
  end  
end 
