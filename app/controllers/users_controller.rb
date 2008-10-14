class UsersController < ApplicationController
  skip_before_filter :login_required
  layout 'sessions'
  
  def new
    @user = User.new
    respond_to do |format|
        format.html { render :action => 'new' }
        format.js { render :action => 'new.rjs' }
    end
  end

  alias_method :index, :new

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        UserNotifier.deliver_new_notification(@user)
        flash[:notice] = 'Su cuenta ha sido creada.'
        format.html { render :action => 'created' }
      else
        @user.passwd = nil
        flash[:notice] = 'La información de su cuenta es incorrecta.'
        format.html { render :action => 'new' }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def confirm
    @user = User.find_by_valid_token(params[:id], params[:token])
    respond_to do |format|
      if !@user.nil?
        @user.activate
        UserNotifier.deliver_activation(@user)
        reset_session # Reset old sessions if exists
        flash[:notice] = 'Su cuenta ha sido activada.'
        format.html { render :action => "activated" }
        format.xml { head :ok }
      else
        flash[:notice] = 'La liga para activar su cuenta ha expirado.'
        format.html { render :action => "index" }
      end
    end
  end

  def recovery_passwd_request
    @user = User.new
    respond_to do |format|
	format.html { render :action => 'recovery_passwd_request' }
        format.js { render :action => 'recovery_passwd_request.rjs'}
    end
  end

  def recovery_passwd
    @user = User.find_by_email(params[:user]['email'])
    respond_to do |format|
      if !@user.nil?
        @user.new_token
        UserNotifier.deliver_password_recovery(@user)
        format.html { render :action => 'recovery_passwd'}
        format.xml { head :ok }
      else
        flash[:notice] = "El correo #{params[:user]['email']} NO existe en el sistema!"
        format.html { render :action => "recovery_passwd_request" }
      end
    end
  end

end
