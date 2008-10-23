class Public::HomePagesController < ActionController::Base
  layout  'public'
  helper :application
  def show
    @record=User.find(params[:id])
    respond_to do |format|
      format.html { render :action => 'show'}
    end
  end

  def show_photo
    @person = Person.find_by_user_id(params[:id])
     response.headers['Pragma'] = 'no-cache'
     response.headers['Cache-Control'] = 'no-cache, must-revalidate'
     if !@person.nil? and !@person.photo.nil? and !@person.photo_content_type.nil?
       send_data(@person.photo, :filename => @person.photo_filename, :type => "image/"+@person.photo_content_type.to_s, :disposition => "inline")
     else
       send_file RAILS_ROOT + "/public/images/comodin.png", :type => 'image/png', :disposition => 'inline'
     end
   end

  #alias_method :show, :index
end
