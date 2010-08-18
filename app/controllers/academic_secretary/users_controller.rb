class AcademicSecretary::UsersController < ApplicationController
  layout 'admin'
  
  respond_to :html, :except => [:search_by_fullname, :search_by_username, :autocomplete_form]
  respond_to :json, :only => [:search_by_fullname, :search_by_username]
  respond_to :js, :only => [:autocomplete_form, :show]

  def index
    respond_with(@users = User.all.paginate(:page => params[:page] || 1, :per_page => 10))
  end

  def new
    respond_with(@user = User.new)
  end

  def create
    respond_with(@user = User.create(params[:user]), :status => :created, :location => academic_secretary_user_path)
  end

  def edit
    respond_with(@user = User.find(params[:id]))
  end

  def show
    respond_with(@user = User.find(params[:id]))
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_with(@user, :status => :updated, :location => academic_secretary_user_path)
  end

  def search_by_fullname
    @records = Person.find_by_fullname(params[:term]).select('id, user_id, firstname, lastname1, lastname2')
    render :json => @records.collect { |record| { :id => record.user_id, :value => record.fullname, :label => record.fullname } }
  end

  def search_by_username
    @records = RemoteUser.username_like params[:term]
    render :json => @records.collect { |record| { :id => record[:username], :value => record[:username], :label =>  record[:friendly_email] } }
  end
  
  def autocomplete_form
    render :action => 'autocomplete_form.js'
  end
end
