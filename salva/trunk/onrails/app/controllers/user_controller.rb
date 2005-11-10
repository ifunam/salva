# user_controller.rb: Manipulate the User Model.
#
# This is a forked work from the Security Model implemented by Bruce Perens:
# http://perens.com/FreeSoftware/ModelSecurity/
#
# And the Perens works should probably be merged with ActiveRBAC:
# https://rbaconrails.turingstudio.com/trac/wiki
#
# We don't use the HTTP authorization, because it's prone to sniffing.
#
# We are using SESSIONS to make the authentication and model_security,
# to define the user privileges, see: 
# RAILS_ROOT/lib{user_support.rb, model_security.rb, modal.rb}
#
# I started out with the Salted Hash login generator, and essentially rewrote
# the whole thing, learning a lot from the previous versions. This is not a
# criticism of the previous work, my goals were different. So, it's fair to
# say that this is derived from the work of Joe Hosteny and Tobias Leutke.
#
class UserController < ApplicationController
  layout 'users'
  helper :application
  helper :ModelSecurity

private
  # Promote the user to belong to a specific group
  def add_to_group(user_id, group_id)
    @usergroup = UsersGroups.new(:user_id => user_id, :group_id => group_id)
    @usergroup.save
  end

  # Send an email to a user with details on how to confirm his login.
  def send_confirmation_email(params)
    url_params = {
      :controller => 'user',
      :action => 'activate',
      :id => @user.id,
      :token => @user.new_token
    }
    url = url_for(url_params)
    UserMailer.deliver_new_user(params, url, @user.token_expiry)
  end

public
  # Require_admin will require an administrative login before the action
  # can be called. It uses Modal, so it will continue to the action if the 
  # login is successful.

  before_filter :require_admin, :only => [ :destroy, :edit]
  
  # Require_login will require a login before the action
  # can be called. It uses Modal, so it will continue to the action if the 
  # login is successful.
  before_filter :require_login, :only => [ :list, :show ]
  
  # Attempt HTTP authentication, and fall back on a login form.
  # If this method is called login_admin (it's an alias), keep trying
  # until an administrator logs in or the user pushes the "back" button.
  def login
    if flash[:login_succeeded]
      redirect_back_or_default :action => :success
      return
    end
    
    @user = User.new
    
    flash[:login_succeeded] = false
    render :action => 'login'
  end
  
  # Log in an administrator. If a non-administrator logs in, keep trying
  # until an administrator logs in or the user pushes the "back" button.
  alias login_admin login

  # Log out the current user, attempt Web Form authentication to log in a new
  # user. The session information skip_user_setup=true tells the server to
  # generate a new Web Form authentication request and ignore the 
  # current_session.
  def logout
    User.sign_off
    reset_session
    flash[:skip_user_setup] = true
    render :action => 'logout'
  end

  # Create a new user.
  def new
    case @request.method
    when :get
      @user = User.new
    when :post
      p = @params['user']
      @user = User.new(p)
      @user.userstatus_id = 1 # Setting as 'new' the userstatus

      if @user.save
        flash['notice'] = 'User created.'
        # Promote the very first user to be an administrator.
        if @user.id == 1
          # The first user account will use the userstatatus_id activated 
          # by default and and don't make that user confirm.
          @user.userstatus_id = 2 
          @user.save
          # Promote the first user to be an administrator(Admin group)
          add_to_group(@user.id, 1)
          User.current = @user
          render :action => 'admin_created'
        else
          add_to_group(@user.id, 2) # Adding to the SALVA group
          # Sending email with the user instructions on how to activate 
          # their account.
          send_confirmation_email(p)
          @email = p['email']
          render :action => 'created'
        end
      else
        flash['notice'] = 'Creation of new user failed.'
      end
    end
  end
  
  # Send out a forgot-password email.
  def forgot_password
    case @request.method
    when :get
      @user = User.new
    when :post
      @user = User.find_first(['email = ?', @params['user']['email']])
      if @user
        url = url_for(:controller => 'user', :action => 'activate', :id => @user.id, :token => @user.new_token)
        UserMailer.deliver_forgot_password(@user, url)
        render :action => 'forgot_password_done'
      else
        flash['notice'] = "Can't find a user with email #{@params['email']}."
        @user = User.new
      end
    end
  end

  def list
    @users = User.find_all
  end

  # Activate a new user, having logged in with a security token. All of the
  # work goes on in 'RAILS_ROOT/lib/user_support.rb'.
  def activate
  end

  # Tell the user the email's on the way.
  def forgot_password_done
  end

  # Tell the user that an action succeeded.
  def success
  end
end
