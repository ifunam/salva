require 'RMagick'
require 'stackcontroller'
require 'sql'
class PersonController < ApplicationController
  include Magick
  include Stackcontroller
  include Sql

  def index
    if has_data? then
      redirect_to :action => 'show'
    else
     redirect_to :action  => 'new'
    end
  end

  def show
    @edit = get_person
  end

  def new
    @edit = model_from_stack || Person.new
  end

  def edit
    @edit = model_from_stack || get_person
  end

  def photo
    @edit = get_record(session[:user], true)
    response.headers['Pragma'] = 'no-cache'
    response.headers['Cache-Control'] = 'no-cache, must-revalidate'
    if !@edit.nil? and !@edit.photo.nil?
      send_data(@edit.photo, :filename => @edit.photo_filename, :type => "image/"+@edit.photo_content_type.to_s, :disposition => "inline")
    else
      send_file RAILS_ROOT + "/public/images/comodin.png", :type => 'image/png', :disposition => 'inline'
    end
  end

  def create
    @edit = Person.new(params[:edit])
    @edit.id = session[:user]
    @edit.moduser_id = session[:user] if session[:user]
    unless redirect_if_stack('new')
      save_photo if !@edit.photo.nil? and @edit.photo.size > 0
      if @edit.save
        flash[:notice] = 'Sus datos personales han sido guardados'
        render :action => 'show'
      else
        flash[:notice] = 'Hay errores al guardar esta información'
        render :action => 'new'
      end
    end
  end

  def update
    if params[:id].to_i == session[:user].to_i
      @edit = Person.find(params[:id])
      @edit.id = session[:user]
      @edit.moduser_id = session[:user] if session[:user]
      unless redirect_if_stack('edit')
        if @edit.update_attributes(params[:edit])
          save_photo if !@edit.photo.nil? and @edit.photo.size > 0
          @edit.save
          flash[:notice] = 'Sus datos personales han sido actualizados'
          render :action => 'show'
        else
          flash[:notice] = 'Hay errores al actualizar esta información'
          render :action => 'edit'
        end
      end
    else
      flash[:notice] = 'Usted no puede modificar la información de otro usuario, pinche transa'
      redirect_to :action => 'index'
    end
  end

  protected

  def save_photo
    @edit.photo_filename = base_part_of(params[:edit]['photo'].original_filename)
    @edit.photo_content_type = base_part_of(params[:edit]['photo'].content_type.chomp)
    @edit.photo = transform_photo(params[:edit]['photo'])
    @edit.photo_content_type = @edit.photo_filename.split('.').last.downcase
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
    photo.to_blob
  end

  def has_data?
    get_record(session[:user]) == nil ? false : true
  end

  def get_person
    model_from_stack || get_record(session[:user])
  end

  def get_record(id,photo=false)
    # To avoid performance problems avoid use the photo attributes  (photo_*)
    if photo == true
      Person.find(:first, :conditions => [ "user_id = ?",  id])
    else
      columns = Person.column_names - ["photo_filename", "photo_content_type", "photo"]
      Person.find(:first, :select => columns.join(', '), :conditions => [ "user_id = ?",  id])
    end
  end

  def clean_photo_attributes
      @edit.photo_filename = nil
      @edit.photo_content_type = nil
      @edit.photo = nil
  end

  def redirect_if_stack(action)
    if params[:stack] != nil
      clean_photo_attributes
      redirect_to options_for_next_controller(@edit, controller_name, action)
      return true
    end
    return false
  end
end

