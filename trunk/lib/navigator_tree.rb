require 'yaml'
module NavigatorTree
  def tree_from_yml(filename='default.yml')
    file =  RAILS_ROOT + '/config/tree/' + filename
    YAML::load_file(file)
  end

  def tree_loader(root='home')
    navtree = Tree.new()
    navtree.data = root
    i = 1
    UserGroup.find(:all, :conditions => ['user_id =?', session[:user]], :order => 'group_id ASC').collect do |record|
      file = record.group.name + '.yml'
      if i == 1
        navtree.addChildren(tree_from_yml(file))
      else
        tree = Tree.new(tree_from_yml(file))
        tree.data = record.group.name
        navtree.addChild(tree)
      end
      i += 1
    end
    navtree
  end

  def get_tree
     session[:navtree] ||= tree_loader
  end
     
  $item_no = -1
  $navigation_array = []
  $navigation_stack = []

  def walk_tree(tree)
    $item_no += 1
    item_no = $item_no

    hash = {}
    hash['breadcrumb'] = $navigation_stack.dup

    $navigation_stack.push(item_no)
    hash['label'] = tree.data

    if tree.is_leaf?
      children = nil
    else
      children = []
      tree.children.each do |child|
        id = nil
        id = walk_tree(child)
        #puts "label #{child.data}  id #{id}" if  item_no == 0
        children << [ child.data, id ]
      end

      # Calcula la lista de vecinos para cada hijo
      prev = nil
      children.each_index { |index|
        id = children[index][1]
        next_item = (index < children.size-1)? children[index+1][1]: nil
        $navigation_array[id]['neighborlinks'] = [ prev, item_no, next_item]
        prev = id
      }
    end

    hash['children'] = children
    $navigation_array[item_no] = hash
    $navigation_stack.pop
    item_no
  end

  def get_navigation_array
    tree = tree_loader
    $item_no = -1
    $navigation_array = []
    walk_tree(tree)
    $navigation_array
  end
 
end
