module NavigatorHelper

  def navbar_list
    tree = @session[:navtree]
    list = []
    tree.path.each { |item|
      list << link_to(item, {:controller => 'navigator'})
    }
    @navbar = list.join('|')
    render(:partial => '/salva/navbar')
  end

  def navtab_list
    tree = @session[:navtree]
    children = tree.children
    counter = 0
    @list = []
    children.each { |child|
      if child.is_leaf?
        @list << link_to(child.data, {:controller => child.data })
      else
        @list << link_to(child.data, {:controller => 'navigator', :item => counter })
      end
      counter += 1
    }    
    render(:partial => '/salva/navtab')
  end
    
end  
