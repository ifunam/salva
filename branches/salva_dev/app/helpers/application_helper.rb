# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper 
  # <head> .... </head>
  def head_title
    "#{@controller.controller_class_name} : #{@controller.action_name}"
  end  
  
  def charset
    @charset || "iso-8859-1"
  end
  
  def icon
    @icon || '/images/favicon.ico'
  end
  
  def style
    @style || 'form'
  end
  
  #############################
  # inside Body Page          #
  #############################
  # TopBar
  # User
  def help_link
    "/doc/help/#{@controller.controller_class_name}/#{@controller.action_name}.html"
  end  
  
  def logout_link
    '/user/logout/'
  end
  
  def sendbug_link
    '/sendbug/'
  end

  def get_user(id,attr=nil)
    attr = 'login' if attr == nil
    user = User.find(id)
    user[attr]
  end
    
  def logged_user
    if session[:user]
      get_user(session[:user])
    end
  end

  def db_moduser(id=nil)
    if id 
      get_user(id)
    else
      'S A L V A'
    end
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
  
  def check_box(id,checked=0,prefix='item')
    check_box_tag("#{prefix}[#{id}][checked]", checked, options = {:id => "#{prefix}_checked"} ) 
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
    date_select (object, attribute, :start_year =>  options[:start_year], :end_year =>  options[:end_year], 
                 :use_month_numbers => true, :order => [:day, :month, :year])
  end

  def country_select(object, options={})
    select(object, "country_id", Country.find_all.collect {|p| [ p.name, p.id ] })
  end
  
  def table_select(object, model, options={})
    options = options.stringify_keys
    if options['prefix'] then
      model_id = options['prefix']+'_'+model.name.downcase+'_id'
    else
      model_id = model.name.downcase+'_id'      
    end
    
    if (options['id'] != nil) then
      "<select name=\"#{object}[#{model_id}]\">\n<option>-- Seleccionar --</option>"+
        options_for_select(
                           model.find(:all, :order => 'name ASC').collect {|p| [ p.name, p.id ]},
                           options['id'])+
        "\n</select>"
    else
      select(object, model_id, 
             model.find(:all, :order => 'name ASC').collect {|p| [ p.name, p.id ]}, :prompt => '-- Seleccionar --'  )
    end       
  end
  
  def remote_upgrade_select(model, name, question='¿Desea agregar este elemento?', options={}) 
    options = options.stringify_keys
    if ( options['prefix'] == nil ) then
      div2upgrade = model
      "if (handleKeyPress(event) && checkString(document.forms[0].#{model}_#{name}.value)) { var agree=confirm('#{question}'); if (agree) {new Ajax.Updater('#{div2upgrade}', '/wizard/upgrade_select?class=#{model}&name='+document.forms[0].#{model}_#{name}.value, {asynchronous:true, evalScripts:true}); return false;} }"
    else 
      prefix = options['prefix']
      div2upgrade = options['prefix']+'_'+model
      "if (handleKeyPress(event) && checkString(document.forms[0].#{div2upgrade}_#{name}.value)) { var agree=confirm('#{question}'); if (agree) {new Ajax.Updater('#{div2upgrade}', '/wizard/upgrade_select?class=#{model}&prefix=#{prefix}&name='+document.forms[0].#{div2upgrade}_#{name}.value, {asynchronous:true, evalScripts:true}); return false;} }"
    end
  end

  def sex(condition)
    condition ? 'Masculino' : 'Femenino'
  end
  
end 
