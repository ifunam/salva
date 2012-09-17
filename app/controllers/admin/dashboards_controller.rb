class Admin::DashboardsController < ApplicationController

  respond_to :html
  layout 'admin'

  def show
    render :action => 'show'
  end
end
