class AcademicSecretary::IdentificationCardsController < ApplicationController
  layout 'admin'
  respond_to :html
  respond_to :js, :only => [:index]

  def index
    respond_with(@users = User.postdoctoral.fullname_asc.activated.search(params[:search]).paginate(:page => params[:page] || 1, :per_page => 10))
  end
end
