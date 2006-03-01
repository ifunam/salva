# Filters added to this controller will be run for all controllers in 
# the application.

# Likewise, all the methods added will be available for all controllers.

require 'authenticated_system'
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :configure_charsets
  before_filter :configure_datestyle
  before_filter :login_required   
  helper :salva, :table, :user, :navigator
  
  def upgrade_select
    @model =  eval(Inflector.classify(@params[:class]))
    @prefix =  @params[:prefix]
    model = @model.new
    model.name = @params[:name]
    model.save
    @id = model.id
    render(:partial => 'salva/upgrade_select')
  end

  def upgrade_select_dest
    # Necesita el id actual
    @model = eval(@params[:model])
    @div = @params[:div]
    @ref_model = @params[:ref_model]
    @prefix = @params[:prefix]
    if @prefix then
      @ref_model.sub!(/^#{@prefix}_/, '')
    end
    @id = @params[:id]
    render(:partial => 'salva/upgrade_options')
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
