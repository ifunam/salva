class PasswordsController < ApplicationController
  layout 'user_resources'
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_password(params[:user])
      flash.now[:notice] = "Password updated!"
    else
      flash.now[:alert]  = "Something is wrong!"
    end
    render :edit
  end
end