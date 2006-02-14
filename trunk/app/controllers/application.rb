# Filters added to this controller will be run for all controllers in 
# the application.

# Likewise, all the methods added will be available for all controllers.

require 'authenticated_system'
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :login_required   
  helper :salva, :table, :user
  
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
  
end
