class UserSchoolarshipsController < ApplicationController
  respond_to :xml
  def destroy
    @user_schoolarship = UserSchoolarship.find(params[:id])
    @user_schoolarship.destroy
    respond_with(@user_schoolarship)
  end
end
