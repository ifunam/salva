class CitiesController < CatalogController
  autocompleted_search_with :name, :name_like_ignore_case
  #respond_to :html, :only => [:list_by_state]
  #respond_to :js, :only => [:show, :new, :remote_form]
  
  def list_by_state
    @cities = City.where(:state_id => params[:state_id]).all
    respond_to do |format|
      format.html { render :action => :list_by_state, :layout => false} 
    end
  end
end

