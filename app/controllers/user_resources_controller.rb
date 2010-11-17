class UserResourcesController < InheritedResources::Base
  layout 'user_resources'

  respond_to :html
  respond_to :js, :only => [:index]

  def index
    params[:search] ||= {}
    params[:search].merge!(:user_id_eq => current_user.id)
    respond_with set_collection_ivar(self.resource_class.search(params[:search]).paginate(:page => params[:page] || 1, :per_page => params[:per_page] || 10))
  end

  def create
    build_resource.user_id = current_user.id
    resource.registered_by_id = current_user.id
    super
  end

  def update
    resource.modified_by_id = current_user.id
    super
  end

  def destroy
    if resource.registered_by_id == current_user.id
      super
    end
  end
end