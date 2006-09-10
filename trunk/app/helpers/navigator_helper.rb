require 'salva_helper'
module NavigatorHelper
  include SalvaHelper

  def navbar_list
    tree = @session[:navtree]
    list = []
    path = tree.path
    counter = path.length - 1
    path.reverse.each { |item|
      list << link_to(get_label(item), 
                      {:controller => 'navigator', :depth => counter})
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
        @list << link_to(img_tag(child.data), { :controller => 'navigator', 
                           :item => counter }) + link_tag_navtab(child.data, counter)
      end
      counter += 1
    }    
    render(:partial => '/salva/navtab')
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

  def title
    controller = @controller.class.name.sub(/Controller/,'').downcase
    imgpath = RAILS_ROOT + "/public/images/" + controller + ".png"
    img = controller
    label = controller
    if controller == 'navigator' then
      tree = @session[:navtree]
      img = tree.data
      label = tree.data
      imgpath = RAILS_ROOT + "/public/images/" + tree.data + "_on.png"
    end
    img = "comodin_salva" if !File.exists?(imgpath) 
    img_tag(img) + get_label(label)
  end

  def navbar_icons
    tree = @session[:navtree]
    controller = @controller.class.name.sub(/Controller/,'').downcase
    path = tree.path
    counter = path.length 
    counter -= 1

    if controller == 'navigator' then
      path.delete_at(0) 
    end

    maxsize = 28
    maxicons = 4
    imgsize = maxsize - ((path.length - 1) * maxicons) if path.length > 0

    links = []
    path.reverse.each {  |image|
      links << link_to(img_tag(image, imgsize), 
                       {:controller => 'navigator', :depth => counter})
      imgsize += 4
      counter -= 1

    }
    links.join(' ')
  end
end  
