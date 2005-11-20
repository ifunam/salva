class UserController < ApplicationController
  helper :user
  # To require logins, use:
  #
  #   before_filter :login_required                            
  #   restrict all actions
  #   before_filter :login_required, :only => [:edit, :update] 
  #   only restrict these actions
  # 
  #   To skip this in a subclassed controller:
  #
  #   skip_before_filter :login_required
  skip_before_filter :login_required
  public
  def index
    login
  end
  
  def login
    return unless request.post?
    self.current_user = auth(@params[:user][:login],
                             @params[:user][:passwd])
    if current_user
      flash[:notice] = "Wey, haz iniciado una sesión en el pinche SALVA!"
      redirect_back_or_default :action => 'success'
    else
      flash[:notice] = "Wey, el login o el password es incorrecto!"
    end
  end
  
  def login_by_token
    self.current_user = User.find_by_id_and_token(@params[:id], @params[:token])
    if current_user
      flash[:notice] = "Wey, haz iniciado una sesión en el pinche SALVA!"
      render :action => 'success'
    else
      flash[:notice] = "Wey, el pase proporcionado no sirve!"
      render :action => 'login'
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    return unless request.post?
    @user = User.new(params[:user])
    if @user.save
      url = url_for(:controller => 'user', :action => 'activate', 
                    :id => @user.id, :token => @user.token)
      UserNotifier.deliver_new_notification(@user, url) 
      render :action => 'create'
    else
      render :action => 'new'
    end
  end

  # Method for activating the current user
  def activate
    @user = User.find(:first, :conditions => [ 'id = ? AND token = ? AND token_expiry >= ?',
                        @params[:id], @params[:token], 0.minutes.from_now ])
    if @user
      reset_session # Reset old sessions if exists
      @user.update_attributes({ :userstatus_id => 2,
                                :token => nil, :token_expiry => nil })
      url = url_for(:controller => 'user', :action => 'login')
      UserNotifier.deliver_activation(@user, url) 
      render :action => 'activated'
    else
      render :action => 'invalid'
    end
  end

  # Send out a forgot-password email.
  def forgot_password
    return unless request.post?
    @user = User.find_first(['email = ?', @params[:user]['email']])
    if @user
      @user.update_attributes({ :token => token_string(10),
                                :token_expiry => 7.days.from_now })
      url = url_for(:controller => 'user', :action => 'login_by_token', 
                    :id => @user.id, :token => @user.token)
      UserNotifier.deliver_forgot_password(@user, url) 
      render :action => 'forgot_password_done'
    else
      flash[:notice] = "El correo #{@params[:user]['email']} NO existe en el salva!"
    end
  end
  
  def logout
    self.current_user = nil
    reset_session
    render :template => 'logout'
  end
  
  protected
  # Authenticates a user by their login name and unencrypted password in the
  # datatabes and verify if the userstatus is equal to 2(Activo)
  def auth(login, passwd)
    @user = User.find_by_login(login) 
    if @user.passwd == encrypt(passwd, @user.salt) \
      and @user.userstatus_id == 2
      return @user 
    end
  end
end
