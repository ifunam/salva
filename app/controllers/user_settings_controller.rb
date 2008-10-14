class UserSettingsController < ApplicationController
  def index
    @record = User.find(session[:user_id])
    @record.passwd = nil
    respond_to do |format|
      format.js { render :action => 'index.rjs' }
      format.html { render :action => 'index' }
    end
  end
  alias_method :show, :index

  def edit
    @record = User.find(session[:user_id])
    @record.passwd = nil
    respond_to do |format|
        if request.xhr?
          format.js { render :action => 'edit.rjs' }
        else
          format.html { render :action => 'edit' }
        end
    end
  end

  def update
    @record = User.find(session[:user_id])
    respond_to do |format|
      if @record.update_attributes(params[:user])
        @msg = params[:remote_msg][:name]
        format.js { render :action => 'update.rjs' }
        format.xml  { head :ok }
      else
        format.js { render :action => "errors.rjs" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end
end