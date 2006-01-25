require 'RMagick'
class PersonalController < ApplicationController
  include Magick
  upload_status_for :create, :update

  def index
    get_personal
    if @edit then
     redirect_to :action => 'show'
    else
     redirect_to :action => 'new'
    end
  end

  def show
     get_personal
  end

  def new
    @edit = Personal.new
  end
  
  def edit 
    get_personal
  end  

  def photo
    get_personal
    if  @edit.photo then
      @headers['Pragma'] = 'no-cache'
      @headers['Cache-Control'] = 'no-cache, must-revalidate'
      send_data (@edit.photo, :filename => @edit.photo_filename, 
                 :type => "image/"+@edit.photo_content_type.to_s, 
                 :disposition => "inline")
    else
      image = '/home/alex/salva/public/images/comodin.png'
      send_data (image.read.first, :filename => @edit.photo_filename, 
                 :type => "image/"+@edit.photo_content_type.to_s, 
                 :disposition => "inline")
    end
  end
  
  def create 
    @edit = Personal.new(params[:edit])
    @edit.id = @session[:user] 
    @edit.moduser_id = @session[:user] if @session[:user]
    save_photo if @edit.photo.size > 0

    if @edit.save 
      flash[:notice] = 'Sus datos personales han sido guardados'
      render :action => 'show'
    else
      flash[:notice] = 'Hay errores al guardar esta información'
      render :action => 'new'
    end
  end
  
  def update
    @edit = Personal.new(params[:edit])
    @edit.id = @session[:user] 
    @edit.moduser_id = @session[:user] if @session[:user]
    save_photo if @edit.photo.size > 0

    if @edit.update 
      flash[:notice] = 'Sus datos personales han sido actualizados'
      render :action => 'show'
    else
      flash[:notice] = 'Hay errores al actualizar esta información'
      render :action => 'edit'
    end
  end
  
  protected
  
  def save_photo
    @edit.photo_filename = base_part_of(params[:edit]['photo'].original_filename)
    @edit.photo_content_type = base_part_of(params[:edit]['photo'].content_type.chomp)
    @edit.photo = transform_photo(params[:edit]['photo'])
    @edit.photo_content_type = 'png'
  end
  
  def base_part_of(file_name)
    name = File.basename(file_name)
    name.gsub(/[^\w._-]/, ' ' )
  end
  
  def transform_photo(photo)
    photo = Magick::Image.from_blob(photo.read).first
    maxwidth = 80
    maxheight = 160
    aspectratio = maxwidth.to_f / maxheight.to_f
    imgwidth = photo.columns
    imgheight = photo.rows
    imgratio = imgwidth.to_f / imgheight.to_f
    imgratio > aspectratio ? scaleratio = maxwidth.to_f / imgwidth : scaleratio = maxheight.to_f / imgheight
    photo.resize!(scaleratio)    
    photo.format = 'PNG'
    photo.to_blob
  end

  def get_personal
    @edit = Personal.find(:first, :conditions => [ "user_id=?", @session[:user]])
  end

end
