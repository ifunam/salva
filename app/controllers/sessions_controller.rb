class SessionsController < ApplicationController
  skip_before_filter :login_required

  def index
    respond_to do |format|
      format.html { render :action => 'index' }
      format.js { render :action => 'index.rjs' }
    end
  end
  alias_method :show, :index
  
  def login
    respond_to do |format|
      if User.authenticate?(params[:user][:login],params[:user][:passwd])
        session[:user_id] = User.find_by_login(params[:user][:login]).id
        flash[:notice] = "Bienvenido(a), ha iniciado una sesión en el SALVA!"
        format.html { redirect_to(prizetypes_path) }
      else
        flash[:notice] = "El login o el password es incorrecto!"
        format.html { render :action => "index" }
      end
    end
  end

  def login_by_token
    respond_to do |format|
      if User.authenticate_by_token?(params[:login], params[:token])
        @user =  User.find_by_login(params[:login])
        session[:user_id] = @user.id
        @user.destroy_token
        flash[:notice] = "Bienvenido(a), por favor cambie su contraseña..."
        format.html { redirect_to(edit_change_password_path) }
      else
        flash[:notice] = "La información es inválida!"
        format.html { render :action => "index" }
      end
    end
  end

  def destroy
    reset_session
    respond_to do |format|
      format.html {  render :action => "logout" }
    end
  end
end
