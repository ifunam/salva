class WebSite::HomePagesController < WebSite::ApplicationController
  layout 'home_page'

  respond_to :html

  def show
    respond_with @record = User.find(params[:id])
  end

  def show_photo
    @person = Person.find_by_user_id(params[:id])
    unless @person.nil?
      response.headers['Pragma'] = 'no-cache'
      response.headers['Cache-Control'] = 'no-cache, must-revalidate'
      image_path = (File.exist? @person.image_path) ? @person.image_path : Rails.root.to_s + "/app/assets/images/avatar_missing_icon.png"
      send_file(image_path, :disposition => 'inline', :filename => File.basename(image_path))
    else
      render :status => 404
    end
   end
end
