# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper 
  # <head> .... </head>
  def head_title
    "#{@controller.controller_class_name} : #{@controller.action_name}"
  end  

  def help_link
    "/doc/help/#{@controller.controller_class_name}/#{@controller.action_name}.html"
  end  
  
  def logout_link
    '/user/logout/'
  end
  
  def sendbug_link
    '/sendbug/'
  end
  
  def action_link(opts={}, html_opts ={})
    image ='/images/invisible_16x16.png'
    onmouseover = "return overlib('#{opts[:alt]}', WIDTH, 20, HEIGHT, 20, RIGHT, BELOW, SNAPX, 2, SNAPY, 2)"
    onmouseout = "return nd()" 
    link_options = { :action => opts[:action], :id => opts[:id] }
    html_options = { :class => opts[:action], :onmouseover => onmouseover, :onmouseout => onmouseout }
    html_options[:confirm] = html_opts[:question] if html_opts[:question] != nil
    link_to(image_tag(image, :size => '16x16', :border => 0, :alt => opts[:alt]), link_options, html_options)
  end
  
  def show_link(options={})
    action_link({:action => 'show', :id => options[:id], :alt => 'Mostrar'})
  end
  
  def edit_link(options={})
    action_link({:action => 'edit', :id => options[:id], :alt => 'Modificar'})
  end
  
  def purge_link(options={})
    action_link({:action => 'purge', :id => options[:id], :alt => 'Borrar'}, {:question => options[:question]})
  end
  
  def check_box(object, id, checked=false, prefix='item_id')
    check_box_tag("#{object}[#{prefix}][]", id, checked = false, options = {:id => prefix}) 
  end
  
  def month_select(object, options={})  
    select(object, options[:field_name] || 'month', [["Enero", 1], ["Febrero", 2], ["Marzo", 3], 
             ["Abril", 4], ["Mayo", 5], ["Junio", 6], ["Julio", 7], ["Agosto", 8],
             ["Septiembre", 9], ["Octubre", 10], ["Noviembre", 11], ["Diciembre", 12]])
  end
  
  def year_select(object, options={})
    year_options = []
    y = Date.today.year
    start_year, end_year = (options[:start_year] || y), (options[:end_year] || y-70)
    step_val = start_year < end_year ? 1 : -1
    
    start_year.step(end_year, step_val) do |year|
      year_options << year
    end     
    select(object, options[:field_name] || 'year', year_options);
  end
  
  def date_for_select(object, attribute, options={})
    year = Date.today.year
    # Tal vez alguien a los 90 años siga produciendo
    options[:start_year] = year - 90 if  options[:start_year] == nil
    # Por si se aparece el pinche 'Doggie Hauser'
    # http://www.bbc.co.uk/comedy/bbctwocomedy/dogtelly/page31.shtml
    options[:end_year] = year - 15 if  options[:end_year] == nil
    date_select(object, attribute, :start_year =>  options[:start_year], 
                :end_year => options[:end_year], :use_month_numbers => true, 
                :order => [:day, :month, :year])
  end
  
  def remote_function_tag(div, with, prefix=nil)
    prefix ?  with = "'prefix=#{prefix}&#{with}" :  with = "'#{with}" 
    remote_function(:update => div, :with => with, :url => {:action => :upgrade_select_dest},  
                    :loading => "Toggle.display('#{div}_note')",
                    :success => "new Effect.BlindUp('#{div}_note', {duration: 0.4}); return false;")
  end
  
  def select_simple(object, model, model_id, ref_model=nil, condition_id=nil, rparams=nil)
    params = [ object, model_id,  model.find(:all, :order => 'name ASC').collect {|p| [ p.name, p.id ]}, {:prompt => '-- Seleccionar --'} ]
    if ref_model and condition_id then
      params = [ object, model_id, model.find(:all, :order => 'name ASC', :conditions => [ ref_model + ' = ?', condition_id ]).collect {|p| [ p.name, p.id ]}, {:prompt => '-- Seleccionar --'} ]
    end
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

  def quickpost(title, partial)
    link_to_function(title, toggle_effect(partial, 'Effect.BlindUp', "duration:0.4", "Effect.BlindDown", "duration:0.4"))    
  end

  def toggle_effect(domid, true_effect, true_opts, false_effect, false_opts)
    "$('#{domid}').style.display == 'none' ? new #{false_effect}('#{domid}', {#{false_opts}}) : new #{true_effect}('#{domid}', {#{true_opts}}); return false;"
  end
  
end 
