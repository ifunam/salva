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
    @headers['Pragma'] = 'no-cache'
    @headers['Cache-Control'] = 'no-cache, must-revalidate'
    send_data (@edit.photo, :filename => @edit.photo_filename, :type => "image/"+@edit.photo_content_type.to_s, :disposition => "inline")
  end
  
  
  def create 
    @edit = Personal.new(params[:edit])
    save_personal('create')
  end
  
  def update
    @edit = Personal.new(params[:edit])
    save_personal('update')
  end
  
  protected
  
  def save_personal(transaction)
    @edit.id = @session[:user] 
    @edit.moduser_id = @session[:user] if @session[:user]
    
    if @edit.photo
      @edit.photo_filename = base_part_of(params[:edit]['photo'].original_filename)
      @edit.photo_content_type = base_part_of(params[:edit]['photo'].content_type.chomp)
      @edit.photo = transform_photo(params[:edit]['photo'])
      @edit.photo_content_type = 'png'
    end

    if ( transaction == 'create') then
      if @edit.save
        msg ='Sus datos personales han sido guardados'
      else
        errmsg = 'Hay errores al guardar esta información'
      end
    else
      if @edit.update
        msg = 'Sus datos personales han sido actualizados'
      else
        errmsg = 'Hay errores al actualizar esta información'
      end
    end  

    if errmsg then
      flash[:notice] = 'Hay errores al actualizar esta información'
      logger.info @edit.errors.full_messages
      redirect_to :action => 'index'
    else
      flash[:notice] = msg 
      redirect_to :action => 'show'
    end
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
