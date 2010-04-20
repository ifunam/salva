class Admin::UsersController < ApplicationController
 respond_to :html
 def index
   respond_with(@users = User.all)
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

 def update
 @user = User.find(params[:id])
   respond_with(@user = @user.update_attributes(params[:user]), :status => :updated, :location => admin_users_path)
 end

end
