class Api::AdscriptionsController < Api::BaseController

  def index
    respond_with(@adscriptions = Adscription.enabled, :only => [:name, :id])
  end

end