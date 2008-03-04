class UserSettingController < ApplicationController
  def initialize
    super
    @model = User
    @update_msg = 'La información ha sido actualizada'
  end
  verify :method => :post, :only => [ :update ]

  def index
    edit
  end

  def edit
    @edit = @model.find(session[:user])
    render :action => 'edit'
  end

  def update
    @edit = @model.find(session[:user])
    if @edit.update_attributes(params[:edit])
      flash[:notice] = @update_msg
    end
    render :action => 'edit'
  end
end
