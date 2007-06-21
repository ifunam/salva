require 'navigator_tree'
require 'stackcontroller'
class NavigatorController < ApplicationController
  include NavigatorTree
  include Stackcontroller

  skip_before_filter :rbac_required

  def index
    navtab
  end

  def navtab
    stack_clear
    tree = get_tree
    #This will help us to avoid a wrong tree when the user makes reload.
    if @request.env['HTTP_CACHE_CONTROL'].nil?
      if !params[:item].nil? then
        tree = tree.children[params[:item].to_i]
      elsif !params[:depth].nil? then
        tree = tree.get_tree_from_parent(params[:depth].to_i)
      end
    end
    @tree = session[:navtree] = tree
    render :action => 'navtab'
  end

  def navbar
    @list = get_tree.path.reverse
    render :action => "navbar", :layout => false
  end

  def trail_of_controllers # Trail of breadcrumb
    controllers =  get_tree.path
    controllers.delete_at(0)
    @list = controllers.reverse
    render :action => "trail_of_controllers", :layout => false
  end

  def navcontrol
    controller = params[:controller_name]
    tree = get_tree
    @nodes = { }
    if controller == 'navigator'
      @nodes = { :left => tree.left_node, :parent => tree.parent,  :right => tree.right_node}
    else
      tree = tree.parent  if tree.children_data.index(controller)  == nil
      index = tree.children_data.index(controller)
      @nodes = { :left => tree.children[index].left_node,  :parent =>  tree.children[index].parent,  :right  => tree.children[index].right_node  }
    end
    render :action => "navcontrol", :layout  => false
  end
end
