require 'labels'
require 'salva'
module NavigatorHelper
  include NavigatorTree
  include Labels
  include Salva
  include Mydigest
  
  def img_tag(filename='salvita_welcome', size=32, ext='.png')
    image_tag(filename+ext, :size => "#{size}x#{size}",  :border => 0,   :alt => "[#{get_label(filename)}]", :valign => 'middle')
  end

  def controller_title
    controller = controller_name
    if controller == 'navigator'
      controller = get_tree.data
    elsif controller == 'wizard'
      if session[:sequence].is_composite
        controller =  Inflector.tableize(session[:sequence].flat_sequence.first.class.name).singularize
      else
        controler = Inflector.tableize(session[:sequence].get_model.class.name).singularize
      end
    end
    image = controller
    image = "comodin_salva" if !File.exists?(RAILS_ROOT + "/public/images/" + controller + ".png")
    img_tag(image) + get_label(controller)
  end

  def controller_name
    @controller_name ||= @controller.class.name.sub(/Controller$/, '').underscore
  end

  def navigation_table(children)
    limit  = 4
    i = 1
    html = []
    links = []
    children.each do |child|
      links << "<span class=\"navtab_item\"> #{link_to_navigation_child(child)}</span>"
      if i >= limit or i == children.size
        limit += 4
        html << links
        links = []
      end
      i += 1
    end unless children.nil?
    html.collect { | links| "<div class=\"navtab_row\">\n"+ links.join("\n") + "\n</div>\n" }
  end

  def link_to_navigation_child(child)
    label = child[0]
    id = child[1]
    if id.is_a? Fixnum
      link_to(img_tag(label), { :id => id }) +
        link_to(get_label(label), { :id => id })
    end
  end

  def breadcrumb_images(list)
    navigation_array = session[:navigation]

    if list.nil?
      item = session[:navigation_item]
      list = navigation_array[item]['breadcrumb'] if !item.nil? and item >= 0
    end
 
    unless list.nil?
      size =   28 - ((list.size - 1) * 4) 
      links = []
      list.collect do |item|
        hash = navigation_array[item]
        label = hash['label']
        id = item
        links << link_to(img_tag(label, size+= 4),  {:controller => 'navigation', :id => id })
      end
      links.join(' ')
    end
  end

  def breadcrumb_links(list)
    navigation_array = session[:navigation]

    if list.nil?
      item = session[:navigation_item]
      list = navigation_array[item]['breadcrumb'] if !item.nil? and item >= 0
    end
 
    unless list.nil?
      links = []
      list.collect do |item|
        hash = navigation_array[item]
        label = hash['label']
        id = item
        links << link_to(get_label(label), { :controller => 'navigation', :id => id })
      end
      links.join(' ')
    end
  end

  def breadcrumb_back
    navigation_array = session[:navigation]
    item = session[:navigation_item]
    unless item.nil?
      list = navigation_array[item]['breadcrumb'] if !item.nil? and item >= 0
      link_to(get_label('back'), { :controller => 'navigation', :id => list.last.to_i }) unless list.nil?
    end
  end  

  def neighborlinks(list)
    navigation_array = session[:navigation]

    if list.nil?
      item = session[:navigation_item]
      list = navigation_array[item]['neighborlinks'] if !item.nil? and item >= 0
    end

    unless list.nil?
      links = []
      list.collect do |item|
        next if item.nil?
        hash = navigation_array[item]
        label = hash['label']
        id = item
        links << link_to(get_label(label), { :controller => 'navigation', :id => id })
      end
      links.join(' ')
    end
  end

end
