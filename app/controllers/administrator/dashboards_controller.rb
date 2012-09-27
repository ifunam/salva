class Administrator::DashboardsController < ApplicationController

  respond_to :html
  layout 'admin'

  def show
    authorize_admin_action!
    render :action => 'show'
  end
end
