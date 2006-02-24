require 'yaml'
class NavigatorController < ApplicationController
  def tree_loader
    ymlfile =  File.join(RAILS_ROOT, 'config', 'tree.yml')
    tree = YAML::parse( File.open(ymlfile) )
    tree.transform    
  end
  
  def get_tree
    if @session[:navtree] then
      @session[:navtree]
    else
      tree = tree_loader
      navtree = Tree.new(tree)
      navtree.data = 'home'
      @session[:navtree] = navtree
      navtree
      end
  end
  
  def index
    navtab
  end
  
  def navbar
    #     @tree = get_tree
  end
  
   def navtab
     item = @params[:item] if @params[:item]
     tree = get_tree
      if item !=nil and tree.children[item.to_i] then
	 tree = tree.children[item.to_i]
	 @session[:navtree] = tree
      elsif @params[:depth] then
        depth = @params[:depth].to_i
        while depth > 0
          tree = tree.parent
          depth += -1
        end
        @session[:navtree] = tree
      end

      @tree = tree  
      render :action => 'navtab'
   end
   
end
