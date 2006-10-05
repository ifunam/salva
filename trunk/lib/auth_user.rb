require 'digest'
module AuthUser
  include Digest
  # To require logins, use:
  #
  #   before_filter :login_required                            # restrict all actions
  #   before_filter :login_required, :only => [:edit, :update] # only restrict these actions
  #
  # To skip this in a subclassed controller:
  #
  #   skip_before_filter :login_required
  # 
  def login_required
    # store current location so that we can 
    # come back after the user logged in
    store_location
    # check if user is logged in and authorized
    return true if logged_in? 
    
    # call overwriteable reaction to unauthorized access
    access_denied and return false 
  end
  
  def auth?(login,passwd)
    if user_exists?(login)
      return true if check_db_passwd?(login,passwd)
    end
    return false
  end

  def auth_user_by_id_and_token?(id,token)
    return true if User.find_by_id_and_token(id, token)
  end

  # move to the last store_location call or to the passed default one
  def redirect_back_or_default(default)
    session[:return_to] ? redirect_to_url(session[:return_to]) : redirect_to(default)
    session[:return_to] = nil
  end
  
  private 
  # store current uri in  the session.
  # we can return to this location by calling return_location
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def logged_in?
    @current_user ||= session[:user] ? User.find_by_id(session[:user]) : nil
  end
  
  # overwrite if you want to have special behavior in case the user is not authorized
  # to access the current operation. 
  # the default action is to redirect to the login screen
  # example use :
  # a popup window might just close itself for instance
  def access_denied
    redirect_to :controller=>"/user", :action =>"login"
  end  
  
  def user_exists?(login)
    return true if User.find(:first, :conditions => [ 'login = ?', login]) 
    return false
  end
  
  # Authenticates a user by their login name and unencrypted password in the
  # datatabes and verify if the userstatus is equal to 2(Activo)
  def check_db_passwd?(login, passwd)
    user = User.find(:first, :conditions => [ 'login = ?', login])
    return true if user.passwd == encrypt(passwd, user.salt) and user.userstatus_id == 2
    return false
  end
end
