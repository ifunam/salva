class AcademicSecretary::IdentificationCardsController < ApplicationController
 layout 'academic_secretary'
  respond_to :html
  respond_to :js, :only => [:index, :edit]
  def index
    respond_with(@users = User.postdoctoral.fullname_asc.activated.paginated_search(params))
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
  
  def edit
    respond_with(@person = Person.find(params[:id]))
  end

  def update
    @person = Person.find(params[:id])
    @person.update_attributes(params[:person])
    render :action => 'update', :layout => false
  end
end
