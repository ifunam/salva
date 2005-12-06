# Filters added to this controller will be run for all controllers in 
# the application.

# Likewise, all the methods added will be available for all controllers.

require 'authenticated_system'
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :login_required   
  helper :salva, :table
  
  def upgrade_select
    @model =  eval(Inflector.classify(@params[:class]))
    @prefix =  @params[:prefix]
    model = @model.new
    model.name = @params[:name]
    model.save
    @id = model.id
    render(:partial => 'salva/upgrade_select')
  end
  
end
