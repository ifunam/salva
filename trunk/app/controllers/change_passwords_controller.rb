class ChangePasswordsController < ApplicationController
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
    @edit.passwd = nil
    render :action => 'edit'
  end

  def update
    @edit = @model.find(session[:user])
    if @edit.update_attributes(params[:edit])
      flash[:notice] = @update_msg
    end
    render :action => 'edit'
  end
  
  def edit_simple
    @edit = @model.find(session[:user])
    @edit.passwd = nil
    render :action => 'edit_simple'
  end
  
end
