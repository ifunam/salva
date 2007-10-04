# Filters added to this controller will be run for all controllers in
# the application.

# Likewise, all the methods added will be available for all controllers.
require 'authentication'
require 'sessions'
require 'rbac'
require 'navigator_tree'
class ApplicationController < ActionController::Base
  include Authentication
  include Sessions
  include Rbac
  include NavigatorTree

  before_filter :login_required
  before_filter :setup_navtree


  helper :table, :theme, :user, :navigator, :date, :select, :checkbox, :paginator, :ajax, :quickpost

  session :session_key => '_salva_session_id'
  protect_from_forgery :secret => 'my-little-salva_cookie'

  skip_before_filter :verify_authenticity_token,  :only => [:update_select,  :auto_complete_for_edit_year, :auto_complete_for_edit_years, :auto_complete_for_edit_endyear, :auto_complete_for_edit_startyear]
  verify :method => :post, :only => [:update_select,  :auto_complete_for_edit_year, :auto_complete_for_edit_years, :auto_complete_for_edit_endyear, :auto_complete_for_edit_startyear]

  def update_select
    render :partial => 'salva/'+params[:partial], :locals => { :id => params[:id], :tabindex => params[:tabindex] }
  end

  def update_simple_observable_select
    render :partial => 'salva/update_simple_observable_select', :locals => { :id => params[:id], :tabindex => params[:tabindex], :partial => params[:partial] }
  end

  def update_select_from_selects
    @params = params
    partial = params[:partial]
    render :partial => 'salva/'+partial
  end

  def update_searchdialog
    partial = params[:partial]
    render(:partial => partial)
  end

  def update_remote_partial
    render :partial => 'salva/'+params[:partial]
  end

  def auto_complete_for_edit_years
    auto_complete_responder_for_years params[:edit][:years]
  end

  def auto_complete_for_edit_startyear
    min = Date.today.year - 90
    max = Date.today.year
    auto_complete_responder_for_years params[:edit][:startyear], min, max
  end

  def auto_complete_for_edit_endyear
    min = Date.today.year - 90
    max = Date.today.year
    auto_complete_responder_for_years params[:edit][:endyear], min, max
  end

  def auto_complete_for_edit_year
    min = Date.today.year - 90
    max = Date.today.year
    auto_complete_responder_for_years params[:edit][:year], min, max
  end

  private
  def auto_complete_responder_for_years(value,min=1,max=90)
    list = [ ]
    for i in (min .. max)
      list << i if i.to_s =~ /^#{value}/
    end
    render :partial => 'salva/autocomplete_list', :locals => {:list => list}
  end

  def  setup_navtree
    if params[:parent] == 'true' and !session[:navtree].nil? and request.env['HTTP_CACHE_CONTROL'].nil?
      session[:navtree] = get_tree.parent if get_tree.has_parent? and get_tree.children_data.index(controller_name).nil?
    end
  end
#  alias :rescue_action_locally :rescue_action_in_public
end
