class Public::OurPeopleController < ActionController::Base
	layout  'public'
  def index
    @adscription = Adscription.find_by_name(params[:adscription_name])
    respond_to do |format|
      format.html { render :action => :index }
    end
  end
  
  def show
    @person = Person.find_by_user_id(params[:id])
     response.headers['Pragma'] = 'no-cache'
     response.headers['Cache-Control'] = 'no-cache, must-revalidate'
     if !@person.nil? and !@person.photo.nil? and !@person.photo_content_type.nil?
       send_data(@person.photo, :filename => @person.photo_filename, :type => "image/"+@person.photo_content_type.to_s, :disposition => "inline")
     else
       send_file RAILS_ROOT + "/public/images/comodin.png", :type => 'image/png', :disposition => 'inline'
     end
   end
end
