class Api::AdscriptionsController < Api::BaseController

  def index
    respond_with(@adscriptions = Adscription.enabled, :only => [:name, :abbrev, :id])
  end

  def show
    respond_with(@adscription = Adscription.find(params[:id]), :only => [:name, :abbrev, :id])
  end

end
