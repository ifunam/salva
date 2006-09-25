require 'navigator_tree'
class NavigatorController < ApplicationController
  include NavigatorTree

  skip_before_filter :rbac_required

  def index
    navtab
  end
  
  def navbar
    @tree = get_tree
  end
  
  def navtab
    item = params[:item] if params[:item]
    tree = get_tree
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
