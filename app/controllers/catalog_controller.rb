class CatalogController < InheritedResources::Base

  respond_to :json, :only => [:search_by_name, :create]
  respond_to :js, :only => [:new]

  def search_by_name
    render :json => {:text => 'Override this method' }.to_json
  end

  def create
    create! do |format|
      format.js { render :json => resource.to_json(:only => [:id, :name]) }
    end
  end

end