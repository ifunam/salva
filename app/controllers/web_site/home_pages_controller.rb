class WebSite::HomePagesController < WebSite::ApplicationController
  layout 'home_page'

  respond_to :html

  def show
    respond_with @record = User.find(params[:id])
  end

  def show_photo
    @person = Person.find_by_user_id(params[:id])
    response.headers['Pragma'] = 'no-cache'
    response.headers['Cache-Control'] = 'no-cache, must-revalidate'
    send_file(@person.image_path, :disposition => 'inline')
   end
end
