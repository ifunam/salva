require 'RMagick'
class PersonalController < ApplicationController
  upload_status_for :create

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

  def new
    @edit = Personal.new
  end
  
  def edit 
    @edit = Personal.find(:first, @session[:user])
  end  

  def photo
    @edit = Personal.find(:first, @session[:user])
    send_data (@edit.photo, :filename => @edit.photo_filename, :type => "image/"+@edit.photo_content_type.to_s, :disposition => "inline")
  end

  def create 
    @edit = Personal.new(params[:edit])
    @edit.id = @session[:user] 
    if @edit.photo
      @edit.photo_filename = base_part_of(params[:edit]['photo'].original_filename)
      @edit.photo_content_type = base_part_of(params[:edit]['photo'].content_type.chomp)
      @edit.photo = params[:edit]['photo'].read
      upload_progress.message = "Enviando su fotografía..."
    end

    if @edit.save
      flash[:notice] = 'Sus datos personales han sido guardados'
      redirect_to :action => 'show'
    else
      flash[:notice] = 'Wey, hay errores al guardar esta información'
      logger.info @edit.errors.full_messages
      redirect_to :action => 'index'
    end
  end

  def update
    @edit = Personal.find(@session[:user])
    if @edit.photo
      @edit.photo_filename = base_part_of(params[:edit]['photo'].original_filename)
      @edit.photo_content_type = base_part_of(params[:edit]['photo'].content_type.chomp)
      @edit.photo = params[:edit]['photo'].read
      upload_progress.message = "Actualizando su fotografía..."
    end
    if @edit.update_attributes(params[:edit])
      flash[:notice] = 'Sus datos personales han sido actualizados'
      redirect_to :action => 'show'
    else
      flash[:notice] = 'Wey, hay errores al guardar esta información'
      logger.info @edit.errors.full_messages
      redirect_to :action => 'index'
    end
  end

  def base_part_of(file_name)
    name = File.basename(file_name)
    name.gsub(/[^\w._-]/, ' ' )
  end
  
end
