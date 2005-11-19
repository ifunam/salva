# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper 
  include Salva

  def getcfg(myvar)
    get(:"#{myvar}", 'config') 
  end
  
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

  def login
    if session[:user]
      user = User.find(session[:user])
      return user.login
    end
  end
  
  # Title
  def title_icon
    "#{@controller.controller_class_name}_32x32.png"
  end
  
  def action_link (id, action, alt, question=nil, image='/images/invisible_16x16.png')
    html_options = { :class => action }
    html_options[:confirm] = question if question != nil
    link_to(image_tag(image, :size => '16x16', :border => 0, :alt => alt),
            {:action  => action, :id => id }, html_options)
  end
  
  def show_link(id, alt='Mostrar')
    action_link(id, 'show', alt)
  end
  
  def edit_link(id, alt='Modificar')
    action_link(id, 'edit', alt)
  end
  
  def purge_link(id, question, alt='Borrar')
    action_link(id, 'purge', alt, question)
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
    select_year(Date.today, :start_year => Date.today.year-70, 
                :end_year => Date.today.year, :prefix => object, :field_name => options[:field_name])
  end
  
  def country_select(object, options={})
    select(object, "country_id", Country.find_all.collect {|p| [ p.name, p.id ] })
  end
  
  def edition_select(object, options={})
    select(object, "editions_id", Edition.find_all.collect {|p| [ p.name, p.id ] })    
  end
  
  def table_select(object, model, options={})
    select(object, model.class.name.downcase+'_id', model.find_all.collect {|p| [ p.name, p.id ] })    
  end
end
