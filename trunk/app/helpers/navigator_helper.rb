require 'navigator_tree'
require 'salva_helper'
module NavigatorHelper
  include SalvaHelper
  include NavigatorTree

  def navbar_list
    tree = get_tree
    path = tree.path
    counter = path.length - 1
    list = []
    path.reverse.collect { |item| 
      list << link_tag_navtab_depth(item, counter)
      counter -= 1
    }
    list.join(' | ')    
  end
  
  def navtab_list
    tree = get_tree
    children = tree.children
    list = children.collect { |child| link_to_node(child) }    
    render(:partial => '/salva/navtab', :locals => { :list => list})
  end
  
  def navbar_icons
    controller = get_controller_name
    path = get_tree.path
    counter = (path.length - 1)
    path.delete_at(0) if controller == 'navigator' or controller == 'wizard'
    imgsize = get_image_size(path.length)
    links = []
    path.reverse.each {  |image|
      links << link_to(img_tag(image, imgsize), {:controller => 'navigator', :depth => counter})
      imgsize += 4
      counter -= 1
    }
    links.join(' ')
  end
  
  def controller_title
    controller = get_controller_name
    image = controller
    if controller == 'navigator' or controller == 'wizard' then
      controller = get_tree.data
      image = controller
    end
    image = "comodin_salva" if !File.exists?(get_image_path(controller))
    img_tag(image) + get_label(controller)
  end

  def link_to_node(child)
    if child.is_leaf?
      link_to(img_tag(child.data), {:controller => child.data }) + link_tag(child.data)
    else
      link_to(img_tag(child.data), { :controller => 'navigator', :item => child.index_for_node }) + 
        link_tag_navtab(child.data, child.index_for_node)
    end
  end
  
  def img_tag(image='salvita_welcome', size=32, ext='.png')
    image_tag(image+ext, :size => "#{size}x#{size}", :border => 0, :alt => '*', :valign => 'middle')
  end
  
  def link_tag(label)
    link_to(get_label(label), { :controller => label })
  end
  
  def link_tag_navtab(label,counter)
    link_to(get_label(label), { :controller => 'navigator', :item => counter})
  end

  def link_tag_navtab_depth(label,counter,prefix=nil)
    if prefix != nil
      link_to(prefix + ' ' + get_label(label), { :controller => 'navigator', :depth => counter})
    else
      link_to(get_label(label), { :controller => 'navigator', :depth => counter})
    end
  end

  def get_controller_name
    @controller_name ||= @controller.class.name.sub(/Controller$/, '').underscore
  end

  def get_image_path(controller)
    RAILS_ROOT + "/public/images/" + controller + ".png"
  end

  def get_image_size(path_length)
    maxsize = 28
    maxicons = 4
    imgsize = maxsize - ((path_length - 1) * maxicons) if path_length > 0
  end

  def navcontrol
    tree = get_tree
    tree.children.collect{ |child| tree = child if child.data == get_controller_name }
    if tree.has_parent?
      list = set_links_for_navcontrol(tree)
      render(:partial => '/salva/navcontrol', :locals => { :list => list})
    end
  end
  
  def set_links_for_navcontrol(tree)
    list = [ ]
    list << link_to_control(tree.left_node)  if tree.has_left_node? 
    list << link_to_control(tree.parent) 
    list << link_to_control(tree.right_node) if tree.has_right_node? 
    list
  end

  def link_to_control(child)
    if child.is_leaf?
      link_tag(child.data)
    else
      link_tag_navtab_depth(child.data, (child.index_for_node + 1), 'Sección')
    end
  end
end
