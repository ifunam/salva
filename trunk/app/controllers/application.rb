# Filters added to this controller will be run for all controllers in 
# the application.

# Likewise, all the methods added will be available for all controllers.

require 'authenticated_system'
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :configure_charsets
  before_filter :configure_datestyle
  before_filter :login_required   
  helper :salva, :table, :user, :navigator, :date, :select
  
  def upgrade_select
    @model =  eval(Inflector.classify(@params[:class]))
    @prefix =  @params[:prefix]
    model = @model.new
    model.name = @params[:name]
    model.save
    @id = model.id
    render(:partial => 'salva/upgrade_select')
  end

  def update_select_dest
    # Necesita el id actual
    @destmodel = eval(@params[:destmodel])
    @origmodel = @params[:origmodel] 
    @id = @params[:id]
    @prefix = @params[:prefix]
    render(:partial => 'salva/update_select_dest')
  end
  
  def configure_charsets
    @response.headers["Content-Type"] = "text/html; charset=ISO-8859-1"
  end

  def configure_datestyle
    suppress(ActiveRecord::StatementInvalid) do
      ActiveRecord::Base.connection.execute  "SET datestyle TO 'SQL, DMY';"
    end
  end
  
end
