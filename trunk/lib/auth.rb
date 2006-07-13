require 'digest/sha2'
module Auth
  
  # Create a security token for use in logging in a user who has forgotten
  # his password or has just created his login.
  def token_string(n)
    s = ""
    char64 = (('a'..'z').collect + ('A'..'Z').collect + ('0'..'9').collect + ['.','/']).freeze
    n.times { s << char64[(Time.now.tv_usec * rand) % 64] }
    s
  end
  
  # Hash a given password with the salt. This method localizes the encryption
  # function so that it can be easily changed.
  def encrypt(passwd, mysalt)
    Digest::SHA512.hexdigest(passwd + mysalt)
  end
  
  # Create a string used for the salted password.
  def salted
    token_string(40)
  end
  
  def logged_in?
    current_user
  end

  # accesses the current user from the session.
  # overwrite this to set how the current user is retrieved from the session.
  # To store just the whole user model in the session:
  #
  #   def current_user
  #     session[:user]
  #   end
  # 
  def current_user
    @current_user ||= session[:user] ? User.find_by_id(session[:user]) : nil
  end

  # store the given user in the session.  overwrite this to set how
  # users are stored in the session.  To store the whole user model, do:
  #
  #   def current_user=(new_user)
  #     session[:user] = new_user
  #   end
  # 
  def current_user=(new_user)
    session[:user] = new_user.nil? ? nil : new_user.id
    @current_user = new_user
  end

  # overwrite this if you want to restrict access to only a few actions
  # or if you want to check if the user has the correct rights  
  # example:
  #
  #  # only allow nonbobs
  #  def authorize?(user)
  #    user.login != "bob"
  #  end
  def authorized?(user)
     true
  end

  # overwrite this method if you only want to protect certain actions of the controller
  # example:
  # 
  #  # don't protect the login and the about method
  #  def protect?(action)
  #    if ['action', 'about'].include?(action)
  #       return false
  #    else
  #       return true
  #    end
  #  end
  def protect?(action)
    true
  end

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
    # skip login check if action is not protected
    return true unless protect?(action_name)

    # store current location so that we can 
    # come back after the user logged in
    store_location
    # check if user is logged in and authorized
    return true if logged_in? and authorized?(current_user)
    
    # call overwriteable reaction to unauthorized access
    access_denied and return false 
  end

  # overwrite if you want to have special behavior in case the user is not authorized
  # to access the current operation. 
  # the default action is to redirect to the login screen
  # example use :
  # a popup window might just close itself for instance
  def access_denied
    redirect_to :controller=>"/user", :action =>"login"
  end  

  # store current uri in  the session.
  # we can return to this location by calling return_location
  def store_location
    session[:return_to] = request.request_uri
  end

  # move to the last store_location call or to the passed default one
  def redirect_back_or_default(default)
    session[:return_to] ? redirect_to_url(session[:return_to]) : redirect_to(default)
    session[:return_to] = nil
  end

  # adds ActionView helper methods
  def self.included(base)
 #   base.send :current_user, :logged_in?
  end
end
