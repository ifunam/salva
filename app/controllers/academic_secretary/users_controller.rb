class AcademicSecretary::UsersController < ApplicationController
  layout 'academic_secretary'
  respond_to :html, :except => [:search_by_fullname, :search_by_username, :autocomplete_form]
  respond_to :json, :only => [:search_by_fullname, :search_by_username]
  respond_to :js, :only => [:autocomplete_form, :show, :user_incharge, :index, :edit_status, :update_status]

  def index
    respond_with(@users = User.postdoctoral.fullname_asc.paginated_search(params)) 
  end

  def list
    @users = User.postdoctoral.fullname_asc.search(params[:search])
    respond_to do |format|
      format.xls do 
        send_data PostdoctoralReporter.new(@users.all).to_xls, :filename => 'posdoctorales_'+ Time.now.strftime("%Y%m%d%H%M%S") + '.xls'
      end
    end
  end

  def new
    respond_with(@user = User.new)
  end

  def create
    respond_with(@user = User.create(params[:user]), :status => :created, :location => academic_secretary_users_path)
  end

  def edit
    respond_with(@user = User.find(params[:id]))
  end

  def show
    respond_with(@user = User.find(params[:id])) do |format|
      format.pdf do
        send_data PostdoctoralCardRequest.new(:user_id => @user.id).to_pdf, :filename => @user.login + '.pdf', :type => 'application/pdf'
      end
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_with(@user, :status => :updated, :location => academic_secretary_user_path(@user))
  end

  def search_by_fullname
    @records = User.not_in_postdoctoral.search(:fullname_like => params[:term]).all
    render :json => @records.collect { |record| { :id => record.id, :value => record.fullname_or_email, :label => record.fullname_or_email } }
  end

  def search_by_username
    @records = User.login_like params[:term]
    render :json => @records.collect { |record| { :id => record.login, :value => record.login, :label => record.login } }
  end
  
  def autocomplete_form
    render :action => 'autocomplete_form.js'
  end

  def edit_status
    @user = User.find params[:id]
    render :action => 'edit_status.js'
  end

  def update_status
    @user = User.find(params[:id])
    @user.update_attribute(:userstatus_id, params[:userstatus_id])
    render :action => 'update_status.js'
  end

  def user_incharge
     respond_with(@user = User.find(params[:id]))
  end
end
