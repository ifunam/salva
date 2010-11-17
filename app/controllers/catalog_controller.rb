class CatalogController < InheritedResources::Base

  respond_to :json, :only => [:autocompleted_search, :create]
  respond_to :js, :only => [:new]

  def self.autocompleted_search_with(attribute, attribute_key)
    define_method :autocompleted_search do
      set_collection_ivar self.resource_class.search(attribute_key.to_sym => params[:term]).all
      render :json => collection.collect { |record| {:id => record.id, :value => record.send(attribute.to_sym), :label => record.send(attribute.to_sym) } }
    end
  end

  def create
    build_resource.registered_by_id = current_user.id
    create! do |format|
      format.js { render :json => resource.to_json(:only => [:id, :name]) }
    end
  end
end