require 'RMagick'
class PersonalController < ApplicationController
  include Magick
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
    @edit.moduser_id = @session[:user] if @session[:user]

    if @edit.photo
      @edit.photo_filename = base_part_of(params[:edit]['photo'].original_filename)
      @edit.photo_content_type = base_part_of(params[:edit]['photo'].content_type.chomp)
      @edit.photo = transform_photo(params[:edit]['photo'])
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
    @edit.id = @session[:user] 
    @edit.moduser_id = @session[:user] if @session[:user]
    if @edit.photo
      @edit.photo_filename = base_part_of(params[:edit]['photo'].original_filename)
      @edit.photo_content_type = base_part_of(params[:edit]['photo'].content_type.chomp)
      @edit.photo = transform_photo(params[:edit]['photo'])
    end
    if @edit.save
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

  def transform_photo(photo)
    photo = Magick::Image.from_blob(photo.read).first
    #       maxwidth = 80
    #       maxheight = 160
    #       aspectratio = maxwidth.to_f / maxheight.to_f
    #       imgwidth = photo.columns
    #       imgheight = photo.rows
    #       imgratio = imgwidth.to_f / imgheight.to_f
    #       imgratio > aspectratio ? scaleratio = maxwidth.to_f / imgwidth : scaleratio = maxheight.to_f / imgheight
    #       photo.resize!(scaleratio)
    photo.to_blob
  end

#  def upload_status
#    render :inline => "<%= upload_progress.completed_percent rescue 0 %> % complete", :layout => false
#  end
end
