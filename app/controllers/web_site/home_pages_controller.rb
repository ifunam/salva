class WebSite::HomePagesController < WebSite::ApplicationController
  layout 'home_page'

  respond_to :html

  def show
    @record = User.find(params[:id])
    respond_with(@record)
  end

  def show_photo
    @person = Person.find_by_user_id(params[:id])
    response.headers['Pragma'] = 'no-cache'
    response.headers['Cache-Control'] = 'no-cache, must-revalidate'
    image_path = Rails.root.to_s + '/public/' + @person.image.file.to_s
    unless File.exists? image_path
      image_path = Rails.root.to_s + "/app/assets/images/avatar_missing_icon.png"
    end
    send_file(image_path, :disposition => 'inline')
   end
end
