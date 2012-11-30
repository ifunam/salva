class  ThesismodalitiesController < InheritedResources::Base

  respond_to :html, :only => :list_by_degree
  def list_by_degree
    @thesismodalities = Thesismodality.where(:degree_id => params[:degree_id]).all
    respond_to do |format|
      format.html { render :action => :list_by_degree, :layout => false} 
    end
  end
end
