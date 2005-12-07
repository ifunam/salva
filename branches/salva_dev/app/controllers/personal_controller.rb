class PersonalController < ApplicationController
  upload_status_for :create
  upload_status_for :status => :custom_status

  def index
    @edit = Personal.find(:first, @session[:user])
    if @edit then
     redirect_to :action => 'show'
    else
     redirect_to :action => 'new'
    end
  end

  def show
    @edit = Personal.find(:first, @session[:user])
  end

  def edit 
    @edit = Personal.find(:first, @session[:user])
  end

  def new
    @edit = Personal.new
  end

  def create 
#    @edit = Personal.new(params[:edit])
#    @edit.id = @session[:user] 
    upload_progress.message = "Enviando su fotografía..."
#    if @edit.save
#      flash[:notice] = 'Sus datos personales han sido guardados'
#      redirect_to :action => 'show'
#    else
#      flash[:notice] = 'Wey, hay errores al guardar esta información'
#      logger.info @edit.errors.full_messages
#      redirect_to :action => 'index'
#    end
  end

  def custom_status
#    render :inline => "<%= upload_progress.completed_percent rescue 0 %> % complete", :layout => false
    render :inline => '<%= upload_progress_status %> <div>Updated at <%= Time.now %></div>', :layout => false
  end


end
