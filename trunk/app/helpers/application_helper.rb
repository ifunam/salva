# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper 
  include Salva
  # Get the string for this legend or label field using simple names in the #{lang}.yml file
  def getstr(mystring) 
    get(:"#{mystring}",'strings') 
  end  
  
  # Get Controller strings:  Using the Class Name 
  def getstrcn(mystring) 
    mystring = "#{@controller.controller_name}_#{mystring}"
    get(:"#{mystring}", 'strings') 
  end  
  
  # Get Controller strings:  Using the Class Name and Action Name of each controller
  def getstrca(mystring) 
    mystring = "#{@controller.controller_name}_#{@controller.action_name}_#{mystring}"
    get(:"#{mystring}", 'strings') 
  end  
  
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

  # Title
  def title_icon
    "#{@controller.controller_class_name}_32x32.png"
  end
  
  def show_link(id, alt)
    link_to(image_tag('/images/invisible_16x16.png', :size => '16x16', :border => 0, :alt => alt),
            {:action  => 'show', :id => id }, :class => 'show')
  end
  
  def edit_link(id, alt)
    link_to(image_tag('/images/invisible_16x16.png', :size => '16x16', :border => 0, :alt => alt),
            {:action  => 'edit', :id => id }, :class => 'edit')
  end
  
  def purge_link(id, alt, question)
    link_to(image_tag('/images/invisible_16x16.png', :size => '16x16', :border => 0, :alt => alt),
            {:action  => 'purge', :id => id}, :class => 'purge', :confirm => question)
  end
end
