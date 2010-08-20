class CitiesController < InheritedResources::Base

  respond_to :html, :only => [:list_by_state]
  respond_to :js, :only => [:show, :new]
  
  def list_by_state
    @cities = City.where(:state_id => params[:state_id]).all
    respond_to do |format|
      format.html { render :action => :list_by_state, :layout => false} 
    end
  end
  
  def create
    create! do |format|
      format.js { render :action => 'show.js' }
    end
  end
end