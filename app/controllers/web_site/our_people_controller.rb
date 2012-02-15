class WebSite::OurPeopleController < WebSite::ApplicationController
  layout 'home_page'
  respond_to :html

  def index
    @collection = Adscription.find_by_name(params[:adscription_name]).users.activated
    respond_with(@collection)
  end

  def list
    @collection = Adscription.find_users_by_name_and_category(params[:adscription_name], params[:category_name])
    respond_with(@collection)
  end
end
