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
    if File.Exists?  @person.image.file.url(:card)
      send_file(@person.image.file.url(:card), :disposition => 'inline')
    else
      send_file RAILS_ROOT + "app/assets/images/avatar_missing_icon.png", :type => 'image/png', :disposition => 'inline'
    end
   end
end
