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
  
end
