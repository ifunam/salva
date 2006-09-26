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
      list << link_to(get_label(item), {:controller => 'navigator', :depth => counter})
      counter -= 1
    }
    list.join(' | ')    
  end
  
  def navtab_list
    tree = get_tree
    children = tree.children
    counter = 0
    list = []
    children.each { |child|
      if child.is_leaf?
        list << link_to(img_tag(child.data), {:controller => child.data }) + link_tag(child.data)
      else
        list << link_to(img_tag(child.data), { :controller => 'navigator', :item => counter }) + link_tag_navtab(child.data, counter)
      end
      counter += 1
    }    
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
  
  def img_tag(image=' salvita_welcome', size=32, ext='.png')
    image_tag(image+ext, :size => "#{size}x#{size}", :border => 0, :alt => '*', :valign => 'middle')
  end
  
  def link_tag(label)
    link_to(get_label(label), { :controller => label })
  end
  
  def link_tag_navtab(label,counter)
    link_to(get_label(label), { :controller => 'navigator', :item => counter})
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
end  
