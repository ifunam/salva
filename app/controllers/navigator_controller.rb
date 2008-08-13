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
    session[:navtab_token] = 'unapinchicadenita' if session[:navtab_token].nil?
    if request.env['HTTP_CACHE_CONTROL'].nil?
        if params[:token] != session[:navtab_token]
          if !params[:item].nil? then
            index = params[:item].to_i
            tree = tree.children[index] if tree.children.size > index and !tree.children[index].nil?
          elsif !params[:depth].nil? then
            tree = tree.get_tree_from_parent(params[:depth].to_i) if tree.has_parent? and !tree.get_tree_from_parent(params[:depth].to_i).nil?
          end
        end
    end
    session[:navtab_token] = params[:token] unless params[:token].nil?
    @tree = session[:navtree] = tree
    render :action => 'navtab'
  end

  def navbar
    controller = params[:controller_name]
    @list = get_tree.path.reverse
    if request.env['HTTP_CACHE_CONTROL'].nil?
      if controller == 'navigator'
        @list = get_tree.parent.path.reverse if get_tree.has_parent?
      else
        if get_tree.has_children? and get_tree.has_parent?
          index = get_tree.parent.children_data.index(controller)
          @list = get_tree.parent.children[index].path.reverse if !index.nil?
        elsif get_tree.has_parent?
          @list.pop
        end
      end
      @list << controller
    end
    render :action => "navbar", :layout => false
  end

  def trail_of_controllers # Trail of breadcrumb
    @list = (get_tree.has_parent?) ? get_tree.parent.path.reverse : get_tree.path.reverse
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
        if !tree.nil? and tree.has_children?
          index = tree.children_data.index(controller)
          @nodes = { :left => tree.children[index].left_node, :parent =>  tree.children[index].parent,  :right  => tree.children[index].right_node  } if !index.nil?
        end
      end
    end
    render :action => "navcontrol", :layout  => false
  end
end

