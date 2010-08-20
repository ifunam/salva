class StatesController < InheritedResources::Base

  respond_to :html, :only => :list_by_country
  def list_by_country
    @states = State.where(:country_id => params[:country_id]).all
    respond_to do |format|
      format.html { render :action => :list_by_country, :layout => false} 
    end
  end
end