require 'labels'
require 'salva'
module NavigatorHelper
  include NavigatorTree
  include Labels
  include Salva

  def navbar_links(list)
    i = list.size
    list.collect { |label| link_to(get_label(label), { :controller => 'navigator', :depth => i -= 1}) }.join(' | ')
  end

  def navtab_links(tree)
    limit  = 4
    i = 1
    html = ''
    tree.children.each do |child|
      html << "<br/> \n" and limit += 4  if i > limit
      html <<   "<span class=\"navtab_item\"> #{link_to_child(child)}</span>"
      i += 1
    end
    html
  end

  def link_to_child(child)
    if child.is_leaf?
      link_to(img_tag(child.data), {:controller => child.data }) +  link_to(get_label(child.data), { :controller => child.data })
    else
      link_to(img_tag(child.data), { :controller => 'navigator', :item => child.index_for_node }) +
        link_to(get_label(child.data), { :controller => 'navigator', :item => child.index_for_node})
    end
  end

  def trail_of_controllers_links(list)
    n = list.size
    size =   28 - ((n - 1) * 4)
    links = []
    list.collect do |item|
      links << link_to(img_tag(item, size+= 4),  {:controller => 'navigator', :depth => n})
      n -= 1
    end
    links.join(' ')
  end

  def img_tag(filename='salvita_welcome', size=32, ext='.png')
    image_tag(filename+ext, :size => "#{size}x#{size}",  :border => 0,   :alt => "[#{get_label(filename)}]", :valign => 'middle')
  end

  def controller_title
    controller = controller_name
    controller = get_tree.data if controller == 'navigator' or controller == 'wizard'
    image = "comodin_salva" if !File.exists?(RAILS_ROOT + "/public/images/" + controller + ".png")
    img_tag(controller) + get_label(controller)
  end

  def controller_name
    @controller_name ||= @controller.class.name.sub(/Controller$/, '').underscore
  end

  def navcontrol_links(nodes)
    links = []
    links << link_to_node(nodes[:left]) unless nodes[:left].nil?
    links << link_to_parent(nodes[:parent]) unless nodes[:parent].nil?
    links << link_to_node(nodes[:right]) unless nodes[:right].nil?
    links.join(' ')
  end

  def link_to_node(node)
    if node.is_leaf?
      link_to(get_label(node.data), { :controller => node.data,  :parent => true})
    else
      link_to(get_label(node.data), { :controller => 'navigator', :item => node.index_for_node})
    end
  end

  def link_to_parent(node)
    num = (node.has_parent?) ? (node.path.size - node.parent.path.size) :  node.path.size
    num -= 1  if (node.data == get_tree.root.data and node.data == get_tree.data)  or node.data ==  get_tree.data
    link_to(get_label(node.data), { :controller => 'navigator', :depth => num})
  end
end
