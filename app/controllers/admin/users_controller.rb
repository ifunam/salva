class Admin::UsersController < ApplicationController
  respond_to :html
  def index
    respond_with(@users = User.all.paginate(:page => params[:page] || 1, :per_page => 15))
  end

  def new
    respond_with(@user = User.new)
  end

  def create
    respond_with(@user = User.create(params[:user]), :status => :created, :location => admin_users_path)
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
    respond_with(@user, :status => :updated, :location => admin_users_path)
  end
end
