require File.join(Rails.root, 'lib/document', 'user_profile')
 class Api::UsersController < Api::BaseController

  def index
    @adscription = Adscription.find(params[:adscription_id])
    respond_to do |format|
      format.xml { render :xml => @adscription.users_to_xml}
    end

  end

  def show
    @user = UserProfile.find(params[:id])
    respond_to do |format|
      format.xml { render :xml => @user.to_xml}
    end
  end

  def find_by_login
    @user = UserProfile.find_by_login(params[:login])
    respond_to do |format|
      format.xml { render :xml => @user.to_xml}
    end
  end

end