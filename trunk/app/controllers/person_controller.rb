require 'RMagick'
require 'stackcontroller'
require 'sql'
class PersonController < ApplicationController
  include Magick
  include Stackcontroller
  include Sql
  # Usaremos las siguientes dos líneas cuando actionpack-imagemagick-0.4.gem y 
  # UploadProgress se declaren oficialmente como código estable, referencias:
  # http://vantulder.net/rails/magick/
  # http://api.rubyonrails.org/classes/ActionController/UploadProgress.html
  # 
  # imagemagick_for RAILS_ROOT + "/public/images"
  # upload_status_for :create, :update
  
  def index
    get_person
    if @edit then
     redirect_to :action => 'show'
    else
     redirect_to :action => 'new'
    end
  end
  
  def show
     get_person
  end

  def new
    @edit = is_this_model_in_stack? ? get_model_from_stack : Person.new 
  end

  def edit 
    get_person
  end  

  def list
     @person_pages, @persons = paginate :person, :per_page => 10
  end
  
  def photo
    get_person
    @headers['Pragma'] = 'no-cache'
    @headers['Cache-Control'] = 'no-cache, must-revalidate'
    if  @edit.photo and  @edit.photo_filename != nil and @edit.photo_content_type.to_s == 'png' then
      send_data(@edit.photo, :filename => @edit.photo_filename, 
                :type => "image/"+@edit.photo_content_type.to_s, 
                :disposition => "inline")
    else
      redirect_to "/images/comodin.png"
    end
  end
  
  def create 
    @edit = Person.new(params[:edit])
    @edit.id = session[:user_id] 
    @edit.moduser_id = session[:user] if session[:user]
    if @params[:stack] != nil
      clean_photo_attributes
      set_model_into_stack(@edit,'new', params[:stack], params[:edit], controller_name) and return true 
    end
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
    @edit = Person.new(params[:edit])
    @edit.id = session[:user_id]
    @edit.moduser_id = session[:user] if session[:user]
    if @params[:stack] != nil
      clean_photo_attributes
      set_model_into_stack(@edit,'edit', params[:stack], params[:edit], controller_name) and return true 
    end
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
  
  def get_person
    @edit = is_this_model_in_stack? ? get_model_from_stack : Person.find(:first, :conditions => [ "user_id=?", session[:user_id]])
  end
  
  def clean_photo_attributes
      @edit.photo_filename = nil
      @edit.photo_content_type = nil
      @edit.photo = nil
  end
end
