require 'navigator_tree'
require 'stackcontroller'
class NavigatorController < ApplicationController
  include NavigatorTree
  include Stackcontroller
    

  skip_before_filter :rbac_required
  before_filter :stack_clear
        			    
  def index
    navtab
  end
  
  def navbar
    @tree = get_tree
  end
  
  def navtab
    item = params[:item] if params[:item]
    tree = get_tree
    if params[:parent] != nil 
      tree = (tree.has_parent?) ? tree.parent : tree.root
    end

    if item !=nil and tree.children[item.to_i] then
      tree = tree.children[item.to_i]
      @session[:navtree] = tree
    elsif params[:depth] then
      depth = params[:depth].to_i
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
