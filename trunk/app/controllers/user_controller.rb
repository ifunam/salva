require 'salva'
class UserController < ApplicationController
  include Salva
  helper :user, :theme
  skip_before_filter :login_required
  skip_before_filter :rbac_required

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :signup, :create, :password_recovery]

  # Signup Methods
  def index
    respond_to do |format|
      format.html # index.rhtml
    end
  end

  def signup
    respond_to do |format|

     if authenticate?(params[:user][:login],params[:user][:passwd])
        set_session_for_user(params[:user][:login])
        flash[:notice] = "Bienvenido (a), ha iniciado una sesión en el SALVA!"
        format.html { redirect_back_or_default :controller => 'navigator' }
      else
        flash[:notice] = "El login o el password es incorrecto!"
        format.html { render :action => "index" }
      end
    end
  end

  def signup_by_token
    respond_to do |format|
    if authenticate_by_token?(params[:id], params[:token])
        session[:user] = params[:id]
        flash[:notice] = "Bienvenido(a), por favor cambie su contraseña..."
        format.html { redirect_back_or_default :controller => 'change_password' }
      else
        flash[:notice] = "La información del token es inválida!"
        format.html { render :action => "index" }
      end
    end
  end

  # User accounts creation methods
  def new
    @user = User.new
    respond_to do |format|
      format.html # index.rhtml
    end
  end

  def create
     @user = User.new(params[:user])
      respond_to do |format|
      if @user.save
        UserNotifier.deliver_new_notification(@user, url_for(:action => 'activate', :id => @user.id, :token => @user.token), get_myinstitution.name)
        format.html { render :action => 'created' }
        format.xml  { head :created, :location => users_url(@user) }
      else
        @user.passwd = nil
        @user.passwd_confirmation = nil
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors.to_xml }
      end
    end
  end

  # Method for activating the current user
  def activate
    @user = User.find(:first, :conditions => [ 'id = ? AND token = ? AND token_expiry >= ?',
                                               params[:id], params[:token], 5.minutes.from_now ])
    respond_to do |format|
      if !@user.nil?
        reset_session # Reset old sessions if exists
        @user.activate
        UserNotifier.deliver_activation(@user, url_for(:action => 'index'), get_myinstitution.name)
        format.html { render :action => "activated" }
        format.xml  { head :ok }
      else
        flash[:notice] = 'La liga para activar su cuenta ha expirado.'
        format.html { render :action => "index" }
      end
    end
  end

  # Recovery password stuff
  def forgotten_password_recovery
    respond_to do |format|
      format.html # index.rhtml
    end
  end

  def password_recovery
   # @user = User.find_first(['email = ?', params[:user]['email']])
   @user = User.find(:first, :conditions => ['email = ?', params[:user]['email']])
 respond_to do |format|
      if !@user.nil?
        @user.new_token
        UserNotifier.deliver_password_recovery(@user, url_for(:action => 'signup_by_token', :id => @user.id, :token => @user.token))
        format.html { render :action => 'password_recovery'}
        format.xml  { head :ok }
      else
        flash[:notice] = "El correo #{params[:user]['email']} NO existe en el salva!"
        format.html { render :action => "forgotten_password_recovery" }
      end
    end
  end

  def logout
    reset_session
  end
end
