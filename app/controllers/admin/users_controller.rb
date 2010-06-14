class Admin::UsersController < ApplicationController
  respond_to :html, :except => [:autocomplete_fullname]
  respond_to :js, :only => [:autocomplete_form, :show]
  respond_to :json, :only => [:autocomplete_fullname]
  def index
    respond_with(@users = User.all.paginate(:page => params[:page] || 1, :per_page => 15))
  end

  def new
    respond_with(@user = User.new)
  end

  def create
    respond_with(@user = User.create(params[:user]), :status => :created)
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
    respond_with(@user, :status => :updated)
  end

  def autocomplete_fullname
    @records = Person.find_by_fullname params[:term]
    @results = @records.collect { |record| { :id => record.user_id, :value => record.fullname, :label => record.fullname } }
    render :json => @results
  end
  
  def autocomplete_form
    render :action => 'autocomplete_form.js'
  end
end
