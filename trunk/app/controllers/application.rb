# Filters added to this controller will be run for all controllers in 
# the application.

# Likewise, all the methods added will be available for all controllers.

require 'auth_user'
require 'rbac'
require 'navigator_tree'
class ApplicationController < ActionController::Base
  include AuthUser
  include Rbac
  include NavigatorTree
  before_filter :configure_charsets
  before_filter :configure_datestyle
  before_filter :login_required   
  before_filter :change_userid
  before_filter :set_user_id

  

  #  before_filter :rbac_required   

  
  helper :salva, :table, :user, :navigator, :date, :select, :checkbox, \
  :paginator, :quickpost
  
  def update_select
    @id = params[:id]
    @tabindex =  params[:tabindex]
    partial = params[:partial]
    render(:partial => 'salva/'+partial)
  end

  def update_searchdialog
    partial = params[:partial]
    render(:partial => partial)
  end

  def configure_charsets
    response.headers["Content-Type"] = "text/html; charset=ISO-8859-1"
  end

  def configure_datestyle
    suppress(ActiveRecord::StatementInvalid) do
      ActiveRecord::Base.connection.execute  "SET datestyle TO 'SQL, DMY';"
    end
  end
  
  def change_userid
    if @params[:user_id]
      if is_admin?(session[:user]) or 
          has_rights_overuser?(session[:user], @params[:user_id]) 
        session[:user_id] = @params[:user_id] 
      end
    end
  end
  
  def set_user_id
    session[:user_id] = session[:user] unless session[:user_id]
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
end
