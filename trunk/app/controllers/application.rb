# Filters added to this controller will be run for all controllers in 
# the application.

# Likewise, all the methods added will be available for all controllers.

require 'authenticated_system'
require 'rbac'
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include Rbac
  before_filter :configure_charsets
  before_filter :configure_datestyle
  before_filter :login_required   
  before_filter :change_userid
  before_filter :set_user_id
  before_filter :rbac_required   
  
  helper :salva, :table, :user, :navigator, :date, :select, :paginator, :quickpost
  
  def update_select
    @id = params[:id]
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
      if is_admin?(session[:user])
        #or 
        #  has_rights_overuser?(session[:user],@params[:user_id])
        session[:user_id] = @params[:user_id] 
      end
    end
  end
  
  def set_user_id
    session[:user_id] = session[:user] unless session[:user_id] 
  end
end
