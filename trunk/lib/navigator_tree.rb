require 'yaml'
module NavigatorTree
  def tree_from_yml
    ymlfile =  File.join(RAILS_ROOT, 'config', 'tree.yml')
    tree = YAML::parse(File.open(ymlfile))
    tree.transform    
  end
  
  def tree_loader
    navtree = Tree.new(tree_from_yml)
    navtree.data = 'home'
    navtree
  end

  def get_tree
    @session[:navtree] ||= tree_loader
  end
end
