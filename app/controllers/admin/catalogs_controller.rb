class Admin::CatalogsController  < ApplicationController
  respond_to :html
  def index
    render :action => :index
  end
end