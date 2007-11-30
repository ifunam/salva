require 'labels'
require 'salva'
module NavigatorHelper
  include NavigatorTree
  include Labels
  include Salva
  include Mydigest
  
  def navbar_links(list)
    list.uniq!
    i = list.size
    list.pop
    list.collect { |label| link_to(get_label(label), { :controller => 'navigator', :depth => i -= 1 }) }.join(' | ')
  end

  def navtab_links(children)
    limit  = 4
    i = 1
    html = []
    links = []
    children.each do |child|
      links << "<span class=\"navtab_item\"> #{link_to_child(child)}</span>"
      if i >= limit or i == children.size
        limit += 4
        html << links
        links = []
      end
      i += 1
    end
    html.collect { | links| "<div class=\"navtab_row\">\n"+ links.join("\n") + "\n</div>\n" }
  end

  def link_to_child(child)
    if child.is_leaf?
      link_to(img_tag(child.data), {:controller => child.data }) +  link_to(get_label(child.data), { :controller => child.data })
    else
      link_to(img_tag(child.data), { :controller => 'navigator', :item => child.index_for_node }) +
        link_to(get_label(child.data), { :controller => 'navigator', :item => child.index_for_node })
    end
  end

  def trail_of_controllers_links(list)
    n = list.size
    size =   28 - ((n - 1) * 4)
    links = []
    list.collect do |item|
      links << link_to(img_tag(item, size+= 4),  {:controller => 'navigator', :depth => n })
      n -= 1
    end
    links.join(' ')
  end

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

  def navcontrol_links(nodes)
    links = []
    links << link_to_node(nodes[:left], nodes[:left].has_children?) unless nodes[:left].nil?
    links << link_to_parent(nodes[:parent])  unless nodes[:parent].nil?
    links << link_to_node(nodes[:right], nodes[:right].has_children?) unless nodes[:right].nil?
    links.join(' ')
  end

  def link_to_node(node, parent_is_leaf)
    if node.is_leaf?
      link_to(get_label(node.data), { :controller => node.data})
    else
      link_to(get_label(node.data), { :controller => 'navigator', :item => node.index_for_node, :parent => parent_is_leaf})
    end
  end

  def link_to_parent(node)
    num = (node.has_parent?) ? (node.path.size - node.parent.path.size) :  node.path.size
    num -= 1  if (node.data == get_tree.root.data and node.data == get_tree.data)  or node.data ==  get_tree.data
    link_to(get_label(node.data), { :controller => 'navigator', :depth => num})
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
