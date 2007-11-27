require 'navigator_tree'
require 'stackcontroller'
class NavigationController < ApplicationController
  include NavigatorTree
  include Stackcontroller

  skip_before_filter :rbac_required
  skip_before_filter :verify_authenticity_token

  def index
    stack_clear
    navigation = get_navigation[params[:id].to_i || 0]
    @children = navigation['children']
    @breadcrumb = navigation['breadcrumb']
    @navcontrol = navigation['navcontrol']
    @controller_name = navigation['label']
  end

private
  
  def get_navigation
    session[:navigation] ||= get_navigation_array
  end
  
end

