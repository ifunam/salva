class PersonalController < ApplicationController

  def index
    @edit = Personal.find(@session[:user])
    if @edit then
      show
    else
      new
    end
  end

  def show
    @edit = Personal.find(@session[:user])
  end
  def edit 
    @edit = Personal.find(@session[:user])
  end
  def new
    @edit = Personal.new
  end

  def create 
    @edit = Personal.new(params[:edit])
    @edit.id = @session[:user] 

    if @edit.save

      flash[:notice] = @create_msg
      redirect_to :action => 'show'
    else
      logger.info "*** Algo esta mal <<wey>>, checalo! ***"
      logger.info @edit.errors.full_messages
      redirect_to :action => 'edit'
    end
  end
end
