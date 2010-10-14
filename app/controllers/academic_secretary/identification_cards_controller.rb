class AcademicSecretary::IdentificationCardsController < ApplicationController
  layout 'admin'
  respond_to :html
  respond_to :js, :only => [:index]
  def index
    respond_with(@users = User.postdoctoral.fullname_asc.activated.search(params[:search]).paginate(:page => params[:page] || 1, :per_page => 10))
  end

  def front
    @user = User.find(params[:id])
    respond_to do |format|
      format.jpg do
        send_data IdentificationCard.new(@user).front, :filename => "#{@user.login}_front.jpg", :type => 'image/jpeg', :disposition => 'attachment'  
      end
    end
  end

  def back
    @user = User.find(params[:id])
    respond_to do |format|
      format.jpg do
        send_data IdentificationCard.new(@user).back, :filename => "#{@user.login}_back.jpg", :type => 'image/jpeg', :disposition => 'attachment'  
      end
    end
  end

end
