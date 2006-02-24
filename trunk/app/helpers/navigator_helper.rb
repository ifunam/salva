require 'salva_helper'
module NavigatorHelper
  include SalvaHelper

  def navbar_list
    tree = @session[:navtree]
    list = []
    path = tree.path
    counter = path.length - 1
    path.reverse.each { |item|
      list << link_to(get_label(item), {:controller => 'navigator', :depth => counter})
      counter -= 1
    }
    list.join(' | ')    
  end

  def navtab_list
    tree = @session[:navtree]
    children = tree.children
    counter = 0
    @list = []
    children.each { |child|
      if child.is_leaf?
        @list << link_to(img_tag(child.data), {:controller => child.data }) + 
          link_tag(child.data)

      else
        @list << link_to(img_tag(child.data), {:controller => 'navigator', :item => counter }) + 
          link_tag_navtab(child.data, counter)
      end
      counter += 1
    }    
    render(:partial => '/salva/navtab')
  end

  def img_tag(image)
    image_tag(image+".png", :size => '32x32', :border => 0, :alt => '*')
  end

  def link_tag(label)
    link_to(get_label(label), { :controller => label })
  end

  def link_tag_navtab(label,counter)
    link_to(get_label(label), { :controller => 'navigator', :item => counter})
  end

  def title
    controller = @controller.class.name.sub(/Controller/,'').downcase
    if controller == 'navigator' then
      tree = @session[:navtree]
      img_tag(tree.data) + get_label(tree.data)
    else
      img_tag(controller) + get_label(controller)
    end
  end

  def navbar_icons
    tree = @session[:navtree]
    path = tree.path
    controller = @controller.class.name.sub(/Controller/,'').downcase
    if controller == 'navigator' then
      path.delete_at(0)
    end
    images = ''
    size = 20
    path.reverse.each {  |item|
      images += imagemagick_tag(item+'.png', "resize(#{size}x#{size})") 
      size += 4
    }
    images
  end

end  
