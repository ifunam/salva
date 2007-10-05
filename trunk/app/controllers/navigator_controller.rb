require 'navigator_tree'
require 'stackcontroller'
class NavigatorController < ApplicationController
  include NavigatorTree
  include Stackcontroller

  skip_before_filter :rbac_required
  skip_before_filter :verify_authenticity_token
  def index
    navtab
  end

  def navtab
    stack_clear
    tree = get_tree
    #This will help us to avoid a wrong tree when the user makes reload.
    if request.env['HTTP_CACHE_CONTROL'].nil?
      if !params[:item].nil? then
        index = params[:item].to_i
        tree = tree.children[index] if tree.children.size > index and !tree.children[index].nil?
      elsif !params[:depth].nil? then
        tree = tree.get_tree_from_parent(params[:depth].to_i) if tree.has_parent? and !tree.get_tree_from_parent(params[:depth].to_i).nil?
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
      @nodes = { :left => tree.left_node, :parent => tree.parent,  :right => tree.right_node} if tree.has_parent?
    else
      index = tree.children_data.index(controller)
      if !index.nil?
        @nodes = { :left => tree.children[index].left_node, :parent =>  tree.children[index].parent,  :right  => tree.children[index].right_node  }
        session[:navtree] = tree.children[index] if !tree.children[index].nil?
      else
        tree = tree.parent
        #        @parent = tree.children_data.join(', ')
        index = tree.children_data.index(controller)
        @nodes = { :left => tree.children[index].left_node, :parent =>  tree.children[index].parent,  :right  => tree.children[index].right_node  } if !index.nil?
      end

    end
    render :action => "navcontrol", :layout  => false
  end
end

