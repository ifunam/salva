class Admin::SuperCatalogController < InheritedResources::Base
  layout 'catalogs'
  respond_to :html
  respond_to :js, :only => [:move_association, :move_associations, :show, :index]

  def index
    set_collection_ivar(self.resource_class.search(params[:search]).paginate(:page => params[:page] || 1, :per_page => params[:per_page] || 10))
    super
  end

  def destroy_all
    params[:ids].each { |id| self.resource_class.find(id).destroy }
    redirect_to collection_url
  end

  def destroy_all_empty_associations
    self.resource_class.destroy_all_with_empty_associations
    redirect_to collection_url
  end

  def move_association
    resource.move_association(params[:association_name], params[:new_id])
    respond_with(set_updated_resource(self.resource_class.find params[:new_id]), :status => :updated)
  end

  def move_associations
    resource.move_associations(params[:new_id])
    respond_with(set_updated_resource(self.resource_class.find params[:new_id]), :status => :updated)
  end

  private
  def set_updated_resource(resource)
    instance_variable_set("@updated_#{resource_instance_name}", resource)
  end
end