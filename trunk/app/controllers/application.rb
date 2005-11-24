# Filters added to this controller will be run for all controllers in 
# the application.

# Likewise, all the methods added will be available for all controllers.

require 'authenticated_system'
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :login_required   
  
  def upgrade_select
    @model =  eval(Inflector.classify(@params[:class]))
    model = @model.new
    model.name = @params[:name]
    model.save
    render (:partial => 'salva/upgrade_select')
  end

end
