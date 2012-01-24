class Api::AdscriptionsController < Api::BaseController

  def index
    respond_with(@adscriptions = Adscription.enabled, :only => [:name, :id])
  end

  def show
    respond_with(@adscription = Adscription.find(params[:id]), :only => [:name, :id])
  end

end