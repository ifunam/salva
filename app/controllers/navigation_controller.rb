require 'navigator_tree'
require 'stackcontroller'
class NavigationController < ApplicationController
  include NavigatorTree
  include Stackcontroller

  skip_before_filter :rbac_required
  skip_before_filter :verify_authenticity_token

  def index
    stack_clear
    id = params[:id].to_i || 0
    navigation = get_navigation[id]
    @children = navigation['children']
    @breadcrumb = navigation['breadcrumb']
    @neighborlinks = navigation['neighborlinks']
    @controller_name = navigation['label']

    session[:navigation_item] = id
    redirect_to :controller => @controller_name if @children.nil? and id > 0
  end
  
private
  
  def get_navigation
    session[:navigation] ||= get_navigation_array
  end
  
end

